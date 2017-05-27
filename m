Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE,STOX_REPLY_TYPE_WITHOUT_QUOTES shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 622C71FD09
	for <e@80x24.org>; Sat, 27 May 2017 10:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750905AbdE0KDN (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 May 2017 06:03:13 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:65294 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750721AbdE0KDM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 May 2017 06:03:12 -0400
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id EYYwdbifLHGLwEYYwdEdD2; Sat, 27 May 2017 11:03:10 +0100
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=dsCZMBo4 c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=8nJEP1OIZ-IA:10 a=uPZiAMpXAAAA:8
 a=anyJmfQTAAAA:8 a=R2two0n6AAAA:8 a=EAlsIX4Swg_t9AmQ--MA:9 a=wPNLvfGTeEIA:10
 a=YJ_ntbLOlx1v6PCnmBeL:22
Message-ID: <8CEDDC40C7D24404976929CF3E7AF6FC@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Git List" <git@vger.kernel.org>
Subject: mergetool: what to do about deleting precious files?
Date:   Sat, 27 May 2017 11:03:09 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfJcCTrwCaOi4bsvdBgOzDrT4hBLAO8HT5/y/Tbs7oL5EbqBUmoAGXWkBGyw6CUjBo2Opc0k/jUR4Hi32M9MdzstOkT+wrQ4yYMlWEr3Q5bzhkTaQ5SnW
 Qp4xmJnt+CxjNZHXY2O7ysVbonwE6P3yA4bKD8GfMfOjXr7G5ebTBvU9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The git book [1] and a few blog posts [2] show how to preserve files which
are in the current branch against changes that are on the branch being
merged in.

e.g. (from [2])

echo '<filemane> merge=ours' >> .gitattributes && # commit
git config --global merge.ours.driver true

(test) $ git checkout demo
(demo) $ git merge -
# <filename> contents are not merged and the original retained.



However what is not covered (at least in the documentation ) is the case
where the file to be ignored is not present on the current branch, but is
present on the branch to be merged in.

Normal expectations would be that in such a case the new file from the
second parent branch would be added to the current branch.

Is there an easy way to use the current mergedriver mechanism to make this
new file from the second parent 'go away' - does one have to delete output
path (%P) or what? (or is this just a documenation issue?) [3]


Inspired by SO Q&A
https://stackoverflow.com/questions/44131926/git-merge-remove-unnecessary-file-folder/44138354#44138354
"
git merge
I'm trying to merge my dev branch to master, but I don't want to merge some
of the files/folders to master branch, because it is not needed now on
Master."


Any suggestions for a simple merge driver to avoid merging and commiting
such precious files from the second parent at merge time?
--
Philip

[1]
http://git-scm.com/book/en/v2/Customizing-Git-Git-Attributes#Merge-Strategies
[2]
https://medium.com/@porteneuve/how-to-make-git-preserve-specific-files-while-merging-18c92343826b
[3]
https://git-scm.com/docs/gitattributes #Defining a custom merge driver:
"The merge driver can learn the pathname in which the merged result will be
stored via placeholder %P."

