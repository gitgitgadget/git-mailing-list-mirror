From: "jones.noamle" <lenoam@gmail.com>
Subject: BUG - git clean
Date: Fri, 11 Oct 2013 14:53:08 -0400
Message-ID: <52584914.6030103@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 11 20:53:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUhq0-0006dQ-CU
	for gcvg-git-2@plane.gmane.org; Fri, 11 Oct 2013 20:53:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752772Ab3JKSxR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Oct 2013 14:53:17 -0400
Received: from mail-qe0-f52.google.com ([209.85.128.52]:56966 "EHLO
	mail-qe0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752628Ab3JKSxN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Oct 2013 14:53:13 -0400
Received: by mail-qe0-f52.google.com with SMTP id w7so3612596qeb.11
        for <git@vger.kernel.org>; Fri, 11 Oct 2013 11:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=hUxmw7ySXFuVhNPrDwk6hLD1Q/bcqcxQ1lpQK1pLqqI=;
        b=DjvcwcKfl7AKQLuZlGUeUymwLfRUek7+DVRHBFBcICdaegMFXE9I1Ku+tew+fF68Bo
         rinF5uOHiHpC8QsKInYmvAKOgVDzV8b5Oj+cBNhHgoaS9SkJIhwr4iblverJDQ5p/C50
         6q763S4YgSVka3chxLYJZjDCJJyDTy9KkcgEbyjHtiY1mjl/gdWIvsoXTFXHhMi/anTA
         iYrT9ZFzmSePhjjOLkQ31r5omvyksTaL5PQzUlxBpg/bLVr6LimT6lpAhaO3o0B6p0IU
         HoyeP9XoLSVm03bWl3LMT5bCrHWtU5gchFlor24e5BUQHC644sbvgCDCgCIviiFcq3Dy
         sD8g==
X-Received: by 10.229.73.6 with SMTP id o6mr32943021qcj.2.1381517589875;
        Fri, 11 Oct 2013 11:53:09 -0700 (PDT)
Received: from [127.0.0.1] (static-71-183-108-28.nycmny.fios.verizon.net. [71.183.108.28])
        by mx.google.com with ESMTPSA id h6sm99902084qej.4.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Oct 2013 11:53:08 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235919>

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

Thanks!
Noam
