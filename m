Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8300020A17
	for <e@80x24.org>; Thu, 19 Jan 2017 22:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752154AbdASWB1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 17:01:27 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:57497 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751426AbdASWBY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 17:01:24 -0500
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id UKizcZ1Wp46SJUKizceOnL; Thu, 19 Jan 2017 21:58:29 +0000
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=CItoZljD c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=IkcTkHD0fZMA:10 a=C_IRinGWAAAA:8
 a=XE3kt0nUDoEIip5ijK8A:9 a=QEXdDO2ut3YA:10 a=VOW5rJRXBamZ5z19bD7L:22
Message-ID: <A2198B6A63224EA79526B7A8BA081B37@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Jacob Keller" <jacob.keller@gmail.com>,
        "David J. Bakeman" <nakuru@comcast.net>
Cc:     "Git mailing list" <git@vger.kernel.org>
References: <58798686.5050401@comcast.net> <CA+P7+xoF8E55-XDnQT-GN1=hEwwq4pOsz7--P-SCy29C7ST3Hg@mail.gmail.com> <5880BB23.8030702@comcast.net>
Subject: Re: merge maintaining history
Date:   Thu, 19 Jan 2017 21:58:31 -0000
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="UTF-8";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfAQhkjgbWN9B+A+bPUt0gnOSR3CKqUR1FeAAI0QFl4101CMeLbHYJXvV4r0AbzVuMsgGfPvun0+cjSVDZN6A/NMgbD6V6HtsVh5MouUrg8GY1RNeWAiY
 uuQNREXRVm1pTha9j8dJgPeTcoKM8VoybC/tSCcSGu4Kq7D4ee6/yqXHvdaONY00Z8Spo/7G7ILP035vW+kp/9de9HbW7Qf1Q6UO3jAajUuMF970YmtLni8P
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "David J. Bakeman" <nakuru@comcast.net>
> On 01/14/2017 10:24 PM, Jacob Keller wrote:
>> On Fri, Jan 13, 2017 at 6:01 PM, David J. Bakeman <nakuru@comcast.net> 
>> wrote:
>>> History
>>>
>>> git cloned a remote repository and made many changes pushing them all to
>>> said repository over many months.
>>>
>>> The powers that be then required me to move project to new repository
>>> server did so by pushing local version to new remote saving all history!
>>>
>>> Now have to merge back to original repository(which has undergone many
>>> changes since I split off) but how do I do that without loosing the
>>> history of all the commits since the original move?  Note I need to push
>>> changes to files that are already in existence.  I found on the web a
>>> bunch of ways to insert a whole new directory structure into an existing
>>> repository but as I said I need to do it on top of existing files.  Of
>>> course I can copy all the files from my local working repository to the
>>> cloned remote repository and commit any changes but I loose all the
>>> history that way.
>>>
>>> Thanks.
>> If I understand it.. you have two remotes now:
>>
>> The "origin" remote, which was the original remote you started with.
>>
>> You have now a "new" remote which you created and pushed to.
>>
>> So you want to merge the "new" history into the original tree now, so
>> you checkout the original tree, then "git merge <new-remote>/<branch>"
>> and then fix up any conflicts, and then git commit to create a merge
>> commit that has the new history. Then you could push that to both
>> trees.
>>
>> I would want a bit more information about your setup before providing
>> actual commands.
> Thanks I think that's close but it's a little more complicated I think
> :<(  I don't know if this diagram will work but lets try.
>
> original A->B->C->D->E->F
>             \
> first branch  b->c->d->e
>
> new repo e->f->g->h
>
> Now I need to merge h to F without loosing b through h hopefully.  Yes e
> was never merged back to the original repo and it's essentially gone now
> so I can't just merge to F or can I?

a quick bikeshed..

You have both repositories, so nothing is lost.

Do note that 'e' commit sha1 in the first branch will be different from the 
sha1 of 'e' commit in the new repo, but both should have the same top level 
tree if they are truly identical.

You can fetch both repositories into a single common repo so you will have 
an --orphan branch of the new repo.

Consider adding a --allow-empty commit e' to the original repo to note what 
happens next (and how to do it), which is to use the replace mechanism to 
bridge the gap between the e of the old repo and the e of the new repo by 
making e of the new repo replace the e' you just created.

This will make it look like 'h' is the natural development of 'a'. Even if e 
& e were not tree-same, you will be able to see a diff. You can now merge 
'h' onto 'F' in whatever way you find appropriate to give the right view of 
the development.

When you push this back upstream, note that the 'replace' is local, so 
upstream sees a gap, but that commit e' has the instructions to rebuild the 
link, should others require it (you may have to push the e' commit 
separately).

--
Philip 

