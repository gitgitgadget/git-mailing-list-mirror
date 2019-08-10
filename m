Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4E0E1F731
	for <e@80x24.org>; Sat, 10 Aug 2019 23:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfHJXze (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Aug 2019 19:55:34 -0400
Received: from mail.farhan.codes ([155.138.165.43]:54676 "EHLO
        mail.farhan.codes" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbfHJXze (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Aug 2019 19:55:34 -0400
X-Greylist: delayed 489 seconds by postgrey-1.27 at vger.kernel.org; Sat, 10 Aug 2019 19:55:33 EDT
Received: from mail.farhan.codes (rainloop [172.16.0.4])
        by mail.farhan.codes (Postfix) with ESMTPSA id C06A413F0F
        for <git@vger.kernel.org>; Sat, 10 Aug 2019 19:47:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=farhan.codes; s=mail;
        t=1565480842; bh=dDPpJG0HQIAyTzZ2yK9IY0pFfVRIqcOZu5DUjg6it40=;
        h=Date:From:Subject:To;
        b=lXQV06u8OJkdaLhtEuuwSqlvzqWFHWaT/LtTFNJ/i8syhFQQsHAxXohkPSmMj/rmH
         wNn6bSny+I+RkcIggYcdgbnvJ2bBnnhM/Xk0euwlk9te+ww4n83mxr9xA/L/HOBl/G
         MzS7eleNcNeE/JW0IatQpVw6cFcH7Uib3ToHPAfE=
MIME-Version: 1.0
Date:   Sat, 10 Aug 2019 23:47:22 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.12.1
From:   "Farhan Khan" <farhan@farhan.codes>
Message-ID: <c1754835efe3aa8a5ac93ee2db4a99c5@farhan.codes>
Subject: How to determine when to stop receiving pack content
To:     git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,=0A=0AI am trying to write an implementation of git clone over ssh and=
 am a little confused how to determine a server response has ended. Speci=
fically, after a client sends its requested 'want', the server sends the =
pack content over. However, how does the client know to stop reading data=
? If I run a simple read() of the file descriptor:=0A=0AA. If I use readi=
ng blocking, the client will wait until new data is available, potentiall=
y forever.=0AB. If I use non-blocking, the client might terminate reading=
 for new data, when in reality new data is in transit.=0A=0AI do not see =
a mechanism to specify the size or to indicate the end of the pack conten=
t. Am I missing something?=0A=0AThanks=0A---=0AFarhan Khan=0APGP Fingerpr=
int: 1312 89CE 663E 1EB2 179C  1C83 C41D 2281 F8DA C0DE
