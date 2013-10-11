From: "jones.noamle@gmail.com" <jones.noamle@gmail.com>
Subject: Bug in git clean
Date: Fri, 11 Oct 2013 15:05:27 -0400
Message-ID: <CAMUDzVQqUT91OTbC21pke6jzF8kWBZJAvnyvHhrt-O3=y5bJLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 11 21:05:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUi26-0006av-T3
	for gcvg-git-2@plane.gmane.org; Fri, 11 Oct 2013 21:05:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756085Ab3JKTFt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Oct 2013 15:05:49 -0400
Received: from mail-pb0-f54.google.com ([209.85.160.54]:52382 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755999Ab3JKTFs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Oct 2013 15:05:48 -0400
Received: by mail-pb0-f54.google.com with SMTP id ro12so4638762pbb.41
        for <git@vger.kernel.org>; Fri, 11 Oct 2013 12:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=8R7Kqf9miQy0rIbZ4fPNWVaSMulUPhKbOFTxksxRxWs=;
        b=XS1H3YqbPJg7rLapQdVuRrrGLfXPsWy0DCytj71l8kLBE/0bpXfpPgoOx24b68U2Hz
         WAeiMQlhXGBGSaHJ1knJPafW9AzzbBNpREVMfgCxpF6UlC+8yabmeqvSiqZMZRxft29b
         jmrWYSMIsB+TlRBTeFXzjvq1wZqJw2ERtHfwptGJa/uXRDazBZACtK6OChUJRfUg8wI/
         QFrtqn3nUAt1evjKGu3NhqxOKVgB7C2dcRDRALCpr+A4LGV9HpLlpLVJfw/w+iTWlXf5
         KiaipJHNku2eixj7UdR1nhtWWcjgBNBgbp44c7+tSqJBl2wUh9N5A24wUOebyFQ0jkd8
         GvYw==
X-Received: by 10.68.244.2 with SMTP id xc2mr21731663pbc.58.1381518347948;
 Fri, 11 Oct 2013 12:05:47 -0700 (PDT)
Received: by 10.66.83.1 with HTTP; Fri, 11 Oct 2013 12:05:27 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235920>

Hi.

Passing to git clean wrong (non-existent) paths together with valid
ones, causes it to delete stuff that it shouldn't.
Am I right?
Script to reproduce:

mkdir test
cd test
git init .
mkdir ba
mkdir ba/ca

# So far so good.
# Should clean directory "ba/ca"
git clean -dn -- ba/ca

# Should clean "ba/ca" and ignore non-existent "j"
# Instead, it wants to delete "ba" totally.
git clean -dn -- ba/ca j

git --version

---------------------------------------------------------------------
Output:

+ mkdir test
+ cd test
+ git init .
Initialized empty Git repository in /home/notroot/test/.git/
+ mkdir ba
+ mkdir ba/ca
+ git clean -dn -- ba/ca
Would remove ba/ca/
+ git clean -dn -- ba/ca j
Would remove ba/
+ git --version
git version 1.7.9.5

---------------------------------------------------------------------

Tested on linux (version 1.7.9.5) and cygwin (1.7.9)

Thanks!
Noam Lewis
Hadas Nahon
