Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BB581F6BF
	for <e@80x24.org>; Tue,  6 Sep 2016 17:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938831AbcIFRrP (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Sep 2016 13:47:15 -0400
Received: from mail-qt0-f179.google.com ([209.85.216.179]:36713 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936212AbcIFRrO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2016 13:47:14 -0400
Received: by mail-qt0-f179.google.com with SMTP id p30so42683947qte.3
        for <git@vger.kernel.org>; Tue, 06 Sep 2016 10:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=b/ytyJWinLaTGxVVV1Uat6OUn9IssUat7VDxo0Zllkw=;
        b=tdlmN7a5JvMt9dGRD9QdvpdbJU2Uv1yzBnzWeCDYfqkV4Dy7qFB9aLdppckEVvwXlv
         2ENwtLDaru9Qr1MKXdMN1SRqQ+Tto73UUYGv20t4RDVE2XnxxHGK0e9fKTgyrNjGyywZ
         eja+RJQ3k6mBBIEN3Jc6vVUWWAFWoxuVIr5o5GJ0nwgeVI3fNTAeMwjGZMcWr1bApckD
         1lelw+84Mjj5X7V3rJggG8edke7zMSLO7V6LUe7McQiaBgdQS9m1mJXsQBChkuAt+Rjn
         fRCM3aL7y+ip4Cm2BJKeCNthKBrTZQfUfuNSkLY1+IbAWniPoR/VHWMpl3B3aY2uwe9G
         s8Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=b/ytyJWinLaTGxVVV1Uat6OUn9IssUat7VDxo0Zllkw=;
        b=VcMtPZKZ3YoX64GGAt9/0V/5+t3rqXjRHlvbp8sDiwbl054miS459hC/jcyJofrAAG
         rX91SQ/7+opxSxt2Mobf38rulJxtrIiX9y7VByzYCgew0bfsnSZ2hU8viZsFlmH1wUxj
         xg1igH2whbuSUupbyQpgprD1/d8PjWr2o9o1gRitICmXqCU27lcxD0xNNEtsAUp57A41
         38cQKy3HdIVHg3Zu5jgpjLoL0RPxCqpE6qDEyI9jVa9sVsJp+kC/1+FLsKtfL4gNzl7a
         HCEfNGIA5Fa9Gk40VGN0K+wP0OPZaO4B3VUwo+fYrX0ZZ4L9qm4jhM4e79DwkThAC9Bm
         EIXQ==
X-Gm-Message-State: AE9vXwNFNPHna53IXwDjV7QtD9791BgGwpcqIUTW0xuheLi3dIE36mxKRsWC/LStvrsGwF6qxotES9X8Eed+ig==
X-Received: by 10.200.49.145 with SMTP id h17mr15945392qte.27.1473184033283;
 Tue, 06 Sep 2016 10:47:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.237.49.227 with HTTP; Tue, 6 Sep 2016 10:47:12 -0700 (PDT)
From:   john smith <wempwer@gmail.com>
Date:   Tue, 6 Sep 2016 19:47:12 +0200
Message-ID: <CAKmQUfa_U-g6vC+SjbQSicEUwO+WofNfzezEEwikeOAeL31W5g@mail.gmail.com>
Subject: How to simulate a real checkout to test a new smudge filter?
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am looking for a way to force smudge filter to run by simulating a
real life checkout. Let's say I just created a new branch and did not
modify any files but want to test my new smudge filter. According to
some answers such as
https://stackoverflow.com/questions/22909620/git-smudge-clean-filter-between-branches
and
https://stackoverflow.com/questions/21652242/git-re-checkout-files-after-creating-smudge-filter
it should be possible by running:

git checkout HEAD --

but in doesn't work with git 2.9.0. Method suggested in accepted
answer here
https://stackoverflow.com/questions/17223527/how-do-i-force-git-to-checkout-the-master-branch-and-remove-carriage-returns-aft
works but I don't like because it seems fragile. Is there a safe way
to do what I want to do in Git still today?

-- 
<wempwer@gmail.com>
