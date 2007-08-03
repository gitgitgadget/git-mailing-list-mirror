From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: bug in t3700-add.sh?
Date: Fri, 3 Aug 2007 16:51:37 -0400
Message-ID: <fcaeb9bf0708031351g5e585a4bj849fbf2ec3720a18@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>,
	"Johannes Sixt" <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Fri Aug 03 22:51:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IH47a-0001w2-79
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 22:51:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761544AbXHCUvj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 16:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761345AbXHCUvj
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 16:51:39 -0400
Received: from an-out-0708.google.com ([209.85.132.247]:65101 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760960AbXHCUvi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 16:51:38 -0400
Received: by an-out-0708.google.com with SMTP id d31so179280and
        for <git@vger.kernel.org>; Fri, 03 Aug 2007 13:51:37 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=gmGn8Uqe9VU65l2milTpsLcY1aSIj3fxPHOqW66JNa8lxpMSH0y2gFlcltKBYsdjIOAQaYaERog3wmkw6sfuGY6A1ElAPAsKd8xzy4ozfa8a9O6lq8DT0SjqujtVNxCKUFOixtTJUiaOlzZJnD6s0If6A+uG2OCO1530HqQWh84=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=YlKbn8N5cj0w+Oe/y83WXgJHZf9nqGKhxihb4kJy3hWAokANjvLrovrL6eGLwxDb2M8qgShW+Q6z69lGDYcXJK8V2H1UpOtMbSSy2N5cv7gLBxyMFqKu8NEbbZ3SZS1axh4GqYz638pfMmW2hEEO6lAQzQ5cWzLmYVyk4nTLKr8=
Received: by 10.100.174.16 with SMTP id w16mr1947685ane.1186174297427;
        Fri, 03 Aug 2007 13:51:37 -0700 (PDT)
Received: by 10.100.198.17 with HTTP; Fri, 3 Aug 2007 13:51:37 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54756>

Hi,

Running test 17, I got this output:

* expecting success:
        git rm --cached -f file symlink &&
        (
                echo "100644 $(git hash-object -w stage1) 1     file"
                echo "100755 $(git hash-object -w stage2) 2     file"
                echo "100644 $(printf $s | git hash-object -w -t blob
--stdin) 1        symlink"
                echo "120000 $(printf $s | git hash-object -w -t blob
--stdin) 2        symlink"
        ) | git update-index --index-info &&
        git config core.filemode 0 &&
        git config core.symlinks 0 &&
        echo new > file &&
        echo new > symlink &&
        git add file symlink &&
        git ls-files --stage | grep "^100755 .* 0       file$" &&
        git ls-files --stage | grep "^120000 .* 0       symlink$"

rm 'file'
rm 'symlink'
printf: usage: printf [-v var] format [arguments]
printf: usage: printf [-v var] format [arguments]
100755 3e757656cf36eca53338e520d134963a44f793f8 0       file
120000 3e757656cf36eca53338e520d134963a44f793f8 0       symlink
*   ok 17: git add with filemode=0, symlinks=0 prefers stage 2 over stage 1

I don't know if "printf $s" was intentional because $s was empty and
caused printf to print out help usage. I have feeling that there is
something wrong here. Anyone can clarify?

Johannes Sixt CC'd as he added this code.
-- 
Duy
