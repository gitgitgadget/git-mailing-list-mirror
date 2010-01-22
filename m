From: David Rydh <dary@math.berkeley.edu>
Subject: Re: [PATCH] git-mv: Fix error with multiple sources.
Date: Fri, 22 Jan 2010 08:49:08 -0800
Message-ID: <D7FDF1CC-CED4-4CE8-9FEC-6A630830504C@math.berkeley.edu>
References: <718290.769818367-sendEmail@darysmbp> <7vhbqeacjm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 22 17:49:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYMhQ-0008Rt-AQ
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 17:49:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755806Ab0AVQtP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2010 11:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755637Ab0AVQtO
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 11:49:14 -0500
Received: from cm05fe.IST.Berkeley.EDU ([169.229.218.146]:38928 "EHLO
	cm05fe.IST.Berkeley.EDU" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755577Ab0AVQtM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Jan 2010 11:49:12 -0500
Received: from [10.136.1.127]
	by cm05fe.ist.berkeley.edu with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.69)
	(auth plain:dary@math.berkeley.edu)
	(envelope-from <dary@math.berkeley.edu>)
	id 1NYMh4-00060k-Ie; Fri, 22 Jan 2010 08:49:12 -0800
In-Reply-To: <7vhbqeacjm.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1077)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137767>


On Jan 21, 2010, at 10:17 PM, Junio C Hamano wrote:

> "David Rydh" <dary@math.berkeley.edu> writes:
> 
>> This commit also fixed two potentially dangerous uses of
>> prefix_filename() -- which returns static storage space -- in
>> builtin-config.c and hash-object.c.
> 
> This should probably be a separate patch.  builtin-hash-object.c also uses
> prefix_filename() first to obtain vpath without strdup() and then uses the
> function to create arg, which seems to be unsafe to me.  I've looked at
> all the hits from 
> 
>    $ git grep -n -e prefix_filename\( -- '*.c'
> 
> and other places seem to be Ok.


Yes, this was how I found these two places. Do you agree that strdup'ing vpath as I did in the patch fixes this flaw? (I assume that builtin-hash-object.c = hash-object.c) I'll split it up into two patches.
