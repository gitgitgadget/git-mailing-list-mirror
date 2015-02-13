From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 8/8] reflog_expire(): lock symbolic refs themselves, not
 their referent
Date: Fri, 13 Feb 2015 21:11:30 +0100
Message-ID: <54DE5A72.6030106@alum.mit.edu>
References: <1423473164-6011-1-git-send-email-mhagger@alum.mit.edu>	<1423473164-6011-9-git-send-email-mhagger@alum.mit.edu>	<CAGZ79kaBGAOt-R1=mSG5H-5p=2UWjZEesktVwQcDAWFC-OW2Eg@mail.gmail.com>	<xmqq61b8t65x.fsf@gitster.dls.corp.google.com>	<CAGZ79kaaQWRXhph=0g3SRHKXMoW8eAp7QG21yuWXWd7OW4M+uA@mail.gmail.com>	<54DCDA42.2060800@alum.mit.edu>	<CAGZ79kZgjRNS3zd4Tif6M66mjkP6-tDpy4FAtio8jiwqHxUtgw@mail.gmail.com>	<54DE259C.4030001@alum.mit.edu>	<xmqqoaoxoffe.fsf@gitster.dls.corp.google.com>	<CAGZ79kZpCjcGeifbLztpNUSq7-3Yy2_GEVPGEQsxrgoZfLFU+g@mail.gmail.com>	<xmqqk2zloeg1.fsf@gitster.dls.corp.google.com>	<CAGZ79kYRi3KYcvNQbkhP0uLFgpJzD+h=P+smOLQy2Msv0C_1kw@mail.gmail.com> <xmqqa90hocc5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	=?UTF-8?B?Q2FybG9zIE1hcnTDrW4gTmlldG8=?= <cmn@elego.de>
To: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 21:18:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YMMhK-0002kh-8D
	for gcvg-git-2@plane.gmane.org; Fri, 13 Feb 2015 21:18:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752332AbbBMUSi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2015 15:18:38 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:58681 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751263AbbBMUSh (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Feb 2015 15:18:37 -0500
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Feb 2015 15:18:37 EST
X-AuditID: 12074414-f797f6d000004084-12-54de5a75619a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id F7.15.16516.57A5ED45; Fri, 13 Feb 2015 15:11:33 -0500 (EST)
Received: from [192.168.69.130] (p5DDB38B4.dip0.t-ipconnect.de [93.219.56.180])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t1DKBUBm028594
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 13 Feb 2015 15:11:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.4.0
In-Reply-To: <xmqqa90hocc5.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRmVeSWpSXmKPExsUixO6iqFsadS/EYM1vU4vpXatZLLqudDNZ
	NPReYbZ4e3MJo0X3lLeMFr19n1gtNm9uZ3Fg97i07iWTx85Zd9k9Fmwq9bh4Sdnj8ya5ANYo
	bpukxJKy4Mz0PH27BO6MY09usBW8Eq2Y+DW6gfG1QBcjJ4eEgInE5IlnWSFsMYkL99azgdhC
	ApcZJa4/8Oli5AKyzzNJbNwwgxkkwSugLTHz4WSwIhYBVYm+da/A4mwCuhKLepqZQGxRgSCJ
	Q6cfs0DUC0qcnPkEyObgEBHwkmibWQwyk1lgDpPEzs9TweYIC8RK/LzzkBVi2QVWibNvL4E1
	cwpYSzxZ1wjWzCygLrF+nhBImFlAXqJ562zmCYwCs5CsmIVQNQtJ1QJG5lWMcok5pbm6uYmZ
	OcWpybrFyYl5ealFuhZ6uZkleqkppZsYIQEvsoPxyEm5Q4wCHIxKPLwv/O6GCLEmlhVX5h5i
	lORgUhLl5Yy4FyLEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhNcuECjHm5JYWZValA+TkuZgURLn
	/bZY3U9IID2xJDU7NbUgtQgmK8PBoSTBGxcJ1ChYlJqeWpGWmVOCkGbi4AQZziUlUpyal5Ja
	lFhakhEPitL4YmCcgqR4gPbOAmnnLS5IzAWKQrSeYlSUEudNAUkIgCQySvPgxsLS2CtGcaAv
	hXkTQKp4gCkQrvsV0GAmoMETZ9wGGVySiJCSamBU8rql9VpM33XrTk2GlFM+v18piHmEqsgc
	/xxlpG0o5/3H+OFDs3jn1ZN4NwhxctU/vZFjU3pCZkak5LQLWqdsi5vFVeaFWPBO 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263827>

On 02/13/2015 08:12 PM, Junio C Hamano wrote:
> [...]
> As we are trying to see a way to move forward to do the right thing
> around reflog, I was wondering if locking only the symbolic ref is a
> sensible endgame.  "The right thing" being:
> 
>    When a symbolic ref S points at underlying ref R, and if R's tip
>    changes from X to Y, we would want to know from the reflog of S
>    that S used to point at X and then changed to point at Y.

Let's first talk about an ideal world if we had complete support for
symbolic references.

Yes, I agree with your principle. Moreover, suppose that S and S2 *both*
point at R, and there is a third symref S3 that points at symref S
(symbolic refs can point at other symbolic refs!):

X <- R <- S <- S3
        \
         S2

Now, if R updated from X to Y (regardless of whether the update is via R
directly or via one of the symrefs), then each of the four reflogs (R,
S, S2, and S3) should gain a new entry reflecting the update.

If S is reseated to point at R2 instead of R, then the reflogs for S and
for S3 should each gain new entries

What locks should we hold? In my opinion, we should hold the locks on
exactly those references (symbolic or regular) whose reflogs we want to
change. So in the first example, we should hold

    $GIT_DIR/$R.lock
    $GIT_DIR/$S.lock
    $GIT_DIR/$S2.lock, and
    $GIT_DIR/$S3.lock

Ideally, we should acquire all of the locks before making any modifications.


Now back to the real world. Currently, if R is changed *through* a
symbolic reference S, then the reflogs for both R and S are updated, but
not the reflogs for any other symbolic references that might point at R.
If R is changed directly, then no symref's reflogs are affected, except
for the special case that HEAD's reflog is changed if it points directly
at R. This limitation is a hack to avoid having to walk symrefs
backwards to find any symrefs that might be pointing at R.

If a symref is reseated, then its reflog is changed but not that of any
symrefs that might be pointed at it.

It might actually not be extremely expensive to follow symrefs
backwards. Symbolic references cannot be packed, so we would only have
to scan the loose references; we could ignore packed refs. But it would
still be a lot more expensive than just updating one file. I don't know
that it's worth it, given that symbolic references are used so sparingly.

I think that the rule about locks as expressed above can be carried over
the the real world:

    We should hold the locks on exactly those references (symbolic
    or regular) whose reflogs we plan to change. We should acquire all
    of the locks before making any changes.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
