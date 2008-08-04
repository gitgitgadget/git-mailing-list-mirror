From: David Christensen <david@endpoint.com>
Subject: Re: [git/perl] unusual syntax?
Date: Mon, 4 Aug 2008 10:01:44 -0500
Message-ID: <77D646CF-448B-434A-B969-653931B4A756@endpoint.com>
References: <be6fef0d0808032149p651309a8o773dca5f16923ee1@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 04 17:02:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQ1aE-0002bH-Vj
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 17:02:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754012AbYHDPBs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 11:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754512AbYHDPBr
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 11:01:47 -0400
Received: from sb3.endpoint.com ([64.34.193.88]:54314 "EHLO mail.endcrypt.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753652AbYHDPBr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 11:01:47 -0400
Received: from [192.168.1.119] (188.142.45.66.cm.sunflower.com [66.45.142.188])
	by mail.endcrypt.com (Postfix) with ESMTP id 6F9F0377E4E;
	Mon,  4 Aug 2008 15:01:45 +0000 (UTC)
In-Reply-To: <be6fef0d0808032149p651309a8o773dca5f16923ee1@mail.gmail.com>
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91368>

> sub _close_hash_and_insert_object {
> 	my ($self) = @_;
>
> 	return unless defined($self->{hash_object_pid});
>
> 	my @vars = map { 'hash_object_' . $_ } qw(pid in out ctx);
>
> 	command_close_bidi_pipe($self->{@vars});
> 	delete $self->{@vars};
> }
> $self->{@vars} evaluates to undef. i can't find any mention of using
> arrays to dereference objects in the manual and elsewhere; is this a
> mistake?


This is a hash slice notation, returning an array of hash values  
matching the corresponding keys.  5.10 removed some syntax warts in  
the case of hash slices; this is more portably expressed as @{$self} 
{@vars}; this should work in 5.10 and earlier versions, and so is the  
preferred syntax.

Regards,

David
--
David Christensen
End Point Corporation
david@endpoint.com
