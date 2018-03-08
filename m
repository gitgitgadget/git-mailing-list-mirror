Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6C981F404
	for <e@80x24.org>; Thu,  8 Mar 2018 14:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965421AbeCHOW3 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 8 Mar 2018 09:22:29 -0500
Received: from mga14.intel.com ([192.55.52.115]:2220 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964801AbeCHOW1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 09:22:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Mar 2018 06:22:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,441,1515484800"; 
   d="scan'208";a="209860637"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by fmsmga005.fm.intel.com with ESMTP; 08 Mar 2018 06:22:26 -0800
Received: from fmsmsx116.amr.corp.intel.com (10.18.116.20) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Thu, 8 Mar 2018 06:22:26 -0800
Received: from hasmsx112.ger.corp.intel.com (10.184.198.40) by
 fmsmsx116.amr.corp.intel.com (10.18.116.20) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Thu, 8 Mar 2018 06:22:26 -0800
Received: from HASMSX109.ger.corp.intel.com ([169.254.3.252]) by
 HASMSX112.ger.corp.intel.com ([169.254.11.127]) with mapi id 14.03.0319.002;
 Thu, 8 Mar 2018 16:22:24 +0200
From:   "Vromen, Tomer" <tomer.vromen@intel.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Bug report: git-stash doesn't return correct status code
Thread-Topic: Bug report: git-stash doesn't return correct status code
Thread-Index: AQHTtleqZ3OCKXPgQ+aMAsqWU0GB6aPGZFQQ
Date:   Thu, 8 Mar 2018 14:22:22 +0000
Message-ID: <8ED425DE0F8BEC45AADD477A8872875788FB761D@hasmsx109.ger.corp.intel.com>
References: <8ED425DE0F8BEC45AADD477A8872875788FB691C@hasmsx109.ger.corp.intel.com>
        <xmqqzi3jzp91.fsf@gitster-ct.c.googlers.com>
 <xmqqina7zji7.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqina7zji7.fsf@gitster-ct.c.googlers.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYTFhY2U0MDctNTI0NS00MWNiLTg2NmItODJiM2RlM2VmYzRjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJcL0pqNkczbm5tXC9wZ0hcL05oQTlcL2x0cW95dWhhSnY0d1AxNVJEalZtWWJqK0JFNVBvRGFnSk94QWF2XC9IXC8wakcxIn0=
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.185.75.169]
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> But stepping back a bit, why do you even need stash save/pop around
> "checkout -b new-feature-branch" (that implicitly branches at the
> tip) in the first place?  

Sorry about that, I meant something like

git stash && git checkout develop && git pull && git checkout -b new-feature-branch && git stash pop

My point is that it is the user's expectation that "git stash" will push to the stash.
Not pushing anything should be considered a failure.

Tomer.

-----Original Message-----
From: Junio C Hamano [mailto:jch2355@gmail.com] On Behalf Of Junio C Hamano
Sent: Wednesday, March 07, 2018 23:03
To: Vromen, Tomer <tomer.vromen@intel.com>
Cc: git@vger.kernel.org
Subject: Re: Bug report: git-stash doesn't return correct status code

Junio C Hamano <gitster@pobox.com> writes:

> "Vromen, Tomer" <tomer.vromen@intel.com> writes:
>
>>> git stash && git checkout -b new-feature-branch && git stash pop
>>
>> This is useful when I realize that I want to open a new branch for my changes (that I haven't committed yet).
>> However, I might have forgotten to save my changes in the editor, so git-stash will give this error:
>>
>> No local changes to save
>
> This is given with "say" and not with "die", as this is merely an
> informational diagnosis.  The command did not find any erroneous
> condition, the command did not fail to do anything it was supposed
> to do, so the command exited with 0 status.

I guess that is only half an answer.  If you really want to avoid
creating the new branch when the working tree and the index are
clean, you'd need to check that yourself before that three-command
sequence.  In our shell script, we use these as such a check:

	git update-index --refresh -q --ignore-submodules
	git diff-files --quiet --ignore-submodules &&
	git diff-index --cached --quiet --ignore-submodules HEAD --

But stepping back a bit, why do you even need stash save/pop around
"checkout -b new-feature-branch" (that implicitly branches at the
tip) in the first place?  "checkout -b" that begins at the current
HEAD does not touch the index nor the working tree and take the
local changes with you to the new branch, so save/pop around it
seems totally pointless.
---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

