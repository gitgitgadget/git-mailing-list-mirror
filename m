Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53F2F2082F
	for <e@80x24.org>; Sat, 15 Jul 2017 15:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751081AbdGOPAs (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Jul 2017 11:00:48 -0400
Received: from elasmtp-dupuy.atl.sa.earthlink.net ([209.86.89.62]:46746 "EHLO
        elasmtp-dupuy.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751063AbdGOPAr (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 15 Jul 2017 11:00:47 -0400
X-Greylist: delayed 2472 seconds by postgrey-1.27 at vger.kernel.org; Sat, 15 Jul 2017 11:00:47 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=earthlink.net;
        s=dk12062016; t=1500130847; bh=h7BJJHN+CRUty6Iykec2TGYFsBxZJ2Miu9zz
        dUsnS4o=; h=Received:Received:Date:From:Reply-To:To:Message-ID:
         Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
         X-Mailer:X-ELNK-Trace:X-Originating-IP; b=sKShVLQCk+JutuWVG5pv7ufQ
        Ho2o4x+kpQRbWUc0lmbDvHnrRgsFENftL0LsMfH0JdWheMzCkmu4D+UqLUtg8i/k6Dn
        o4sz1BX5nyNnmETYAVJD4v2hbrazpSI5XatT+d6PIRYqQowU1kgY01ORedoJVmIO790
        4ZgSYZczxpIs8TMVuv8NKS2ddoqLbwyRM1aB4rDUbw9IeHnF/bgw9Z1xKwK5MUzT93K
        VJh9uUukAQF9jV+5eg+lVUtTtMEyAQSIJsWu7QZamXjlEEwvAwWn+6zm78mDHCtdckl
        tf0/GrVkHoyompqgaYmnM7WAtCO7K2WJfn4n8tqc3mAjGzKn4g==
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=dk12062016; d=earthlink.net;
  b=ZdMicY2b1g+izRcpCr/yOG/sNdjW/g1c+4NJ5m9/avJ8J3a80jJ6NImxIVls+bnqcKhZgpgwhlDRPYMGdnOojWp8aRXu7QQweDUuHAv0KBKYGo8+pWw263cTIC7UExJ0xCyfdnUG33O+LH+OdHGS0NErNLcLLRLNPUlSDobHeq3oIYmsy2RroZSoZz3KfAzVAygQsef+y4bOY8Qlc99AQ/wFK9AE/ZOcJdIUDqUG9gAjdBjx4zfU5HEeIxZhnZ1G0zVoLfGcDNnlzgJU0/ISf8nLd3lEdnDQnVMaakqP/sIB8DWjFwJWDOyXI1LEnzAZ1WOKyMDdjqWrdtE+WOs/gw==;
  h=Date:From:Reply-To:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:X-ELNK-Trace:X-Originating-IP;
Received: from [209.86.224.37] (helo=elwamui-karabash.atl.sa.earthlink.net)
        by elasmtp-dupuy.atl.sa.earthlink.net with esmtpa (Exim 4.67)
        (envelope-from <jjfoerch@earthlink.net>)
        id 1dWNuw-0006MM-Eq
        for git@vger.kernel.org; Sat, 15 Jul 2017 10:19:34 -0400
Received: from 98.250.1.226 by webmail.earthlink.net with HTTP; Sat, 15 Jul 2017 10:19:34 -0400
Date:   Sat, 15 Jul 2017 10:19:34 -0400 (GMT-04:00)
From:   John J Foerch <jjfoerch@earthlink.net>
Reply-To: John J Foerch <jjfoerch@earthlink.net>
To:     git@vger.kernel.org
Message-ID: <18894679.1800.1500128374439@elwamui-karabash.atl.sa.earthlink.net>
Subject: [FEATURE] git-commit option to prepend filename to commit message
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: EarthLink Zoo Mail 1.0
X-ELNK-Trace: c53e46bc05df04c91aa676d7e74259b7b3291a7d08dfec7983a8f5f33cfafa4255d7bcf5d893b215350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 209.86.224.37
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I had an idea for a feature for git commit that I wanted to pass along and see if maybe others would also think this would be useful.

Very often, I make commits that affect a single file, and have simple commit messages of this form:

    <filename>: <what changed>

The feature would be a command line option for git commit that would automatically prepend the "<filename>: " to the commit message.  The different cases of its behavior could be:

 - commit affecting a single file, with commit message given by -m:

   : prepend "<filename>: " to the message given by -m

 - commit affecting a single file, with commit message from editor:

   : pre-fill commit message template with "<filename>: "

 - commit affecting multiple files:

   : use common base directory of all affected files for <filename>, behaviors as above for use with -m or editor.

Anybody think that this or something like it would be a good convenience?

Thank you,

John Foerch
