From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fix git-svn for SVN 1.7
Date: Thu, 02 Aug 2012 15:05:30 -0700
Message-ID: <7va9ydc5lh.fsf@alter.siamese.dyndns.org>
References: <1343468872-72133-1-git-send-email-schwern@pobox.com>
 <20120802103122.GA24385@dcvr.yhbt.net> <20120802160753.GA17158@copier>
 <20120802205123.GA14391@dcvr.yhbt.net>
 <7vmx2dc7lw.fsf@alter.siamese.dyndns.org>
 <20120802214201.GB24385@dcvr.yhbt.net> <20120802215544.GA28193@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	robbat2@gentoo.org, bwalton@artsci.utoronto.ca,
	"Michael G. Schwern" <schwern@pobox.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Aug 03 00:06:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sx3X1-0005If-UI
	for gcvg-git-2@plane.gmane.org; Fri, 03 Aug 2012 00:06:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752689Ab2HBWFe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Aug 2012 18:05:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50432 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752470Ab2HBWFd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2012 18:05:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 173288788;
	Thu,  2 Aug 2012 18:05:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3AgUWb/rh4uxxh6titCBh3yZrJ0=; b=Wkd4S/
	LYeLfjJ/DvnVPVh3cnB7OtXSIuHp+SizVpkEeimUDroPlIivHgwPYEN2O/tHYeLa
	0qV5aOAFapVl7LPiB9QDAYG8c/CLWOYmVW1tDDG9wERIBJuATBqK/ewayT6ffs2t
	jKH747rQRo1w2+lht1Fffsen0RxIv8C3OcEbA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AOYO2yG4gU2Qq6MtSBS0LEXftCZf9f5T
	aAIoVNSCkSuwQO7S8ZQ2NMoxnMbc/gRm27CEJD8TlUdcm6yv2LVaeApWsifJQwdr
	89/KJqY9LjueENQ8OM4yhj1hZuFEfhn1U/XyupdQ+7DQIni0xW6ejI2+pLSuZhHJ
	obbKq0CufyM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 039588787;
	Thu,  2 Aug 2012 18:05:33 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5DA3B8785; Thu,  2 Aug 2012
 18:05:32 -0400 (EDT)
In-Reply-To: <20120802215544.GA28193@dcvr.yhbt.net> (Eric Wong's message of
 "Thu, 2 Aug 2012 21:55:44 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2DA4DB8A-DCEE-11E1-92BE-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202802>

Eric Wong <normalperson@yhbt.net> writes:

> Eric Wong <normalperson@yhbt.net> wrote:
>> Junio C Hamano <gitster@pobox.com> wrote:
>> > Eric Wong <normalperson@yhbt.net> writes:
>> > > Thanks for reminding me, I went back to an old chroot 1.4.2 indeed
>> > > does fail canonicalization.
>> > >
>> > > Will bisect and squash a fix in.
>> > 
>> > Oops; should I eject this out of next and wait for a reroll, then?
>> 
>> Your call, I doubt anybody on next uses SVN 1.4.2.   Rerolling now.
>
> OK, rerolled with the patch in
> http://mid.gmane.org/20120802215141.GA5284@dcvr.yhbt.net squashed into
> [PATCH 11/20] git-svn: path canonicalization uses SVN API
>
> The following changes since commit 05a20c87abd08441c98dfcca0606bc0f8432ab26:
>
>   Merge git://github.com/git-l10n/git-po (2012-08-01 15:59:08 -0700)
>
> are available in the git repository at:
>
>
>   git://bogomips.org/git-svn master
>
> for you to fetch changes up to 5eaa1fd086e826b1ac8d9346a740527edbdb3c34:
>
>   git-svn: remove ad-hoc canonicalizations (2012-08-02 21:46:06 +0000)

Thanks.

Will park in 'pu' for now, and depending how it goes, I may be
tempted to merge it down to 'next', but seeing how quickly an issue
was found, it is not likely I'd feel it safe enough to merge it to
'master' before the upcoming release.
