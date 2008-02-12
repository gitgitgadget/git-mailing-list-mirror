From: "Rhodes, Kate" <masukomi@gmail.com>
Subject: [Bug] git-status shows bad instructions prior to first commit
Date: Mon, 11 Feb 2008 19:59:39 -0500
Message-ID: <F1B5775C-1C11-4C30-B72E-9EB4076613A5@gmail.com>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 12 02:00:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOjVo-0003H2-Vp
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 02:00:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752070AbYBLA7z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 19:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751899AbYBLA7s
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 19:59:48 -0500
Received: from rn-out-0910.google.com ([64.233.170.191]:30892 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751835AbYBLA7q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 19:59:46 -0500
Received: by rn-out-0910.google.com with SMTP id i24so6349896rng.19
        for <git@vger.kernel.org>; Mon, 11 Feb 2008 16:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to:content-type:content-transfer-encoding:mime-version:subject:date:x-mailer;
        bh=73vjQ55r+hmgVtA/V5vT1BXeepis3EcCO/JwGlBi0bk=;
        b=fE3ICVL6rWLpcS1WsuNm3rO55u6JXNH4Es5QKRT5kbOmE4dkjlKU+eyIEEk7pVQjeqOH+8WhxrdXbeabjrs8y/g61eAiPYD9fQEBaxDYSPrGMKGpxZUwG7vUqe41ABacZGOeMiAhC6Bt8JHJGh9q1wP4N8aHkM3CkaNGQT2Sxpg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding:mime-version:subject:date:x-mailer;
        b=xzfjYXer5psJg0jlEQ94J7RiVBYSTfPx1qoIhF48tpuPcRne4/cpyk+IhGJuhGskl4kqlhlhiwpWt1UcJOEccyhM9NYQvK0OCSxmsv6gNR8O75owsLaIWZstdOh3GJ1DWllgmDyzyWtjbSzewkutOzLf+q6RqkAnU3da03A0RJw=
Received: by 10.150.11.6 with SMTP id 6mr229716ybk.165.1202777985573;
        Mon, 11 Feb 2008 16:59:45 -0800 (PST)
Received: from ?192.168.1.103? ( [72.93.197.103])
        by mx.google.com with ESMTPS id 26sm41960849wrl.29.2008.02.11.16.59.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Feb 2008 16:59:43 -0800 (PST)
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73613>

git-status incorrectly reports that you should

# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#


when working on the Initial commit.

To reproduce
mkdir foo
cd foo
touch a.txt
git init
git add a.txt
git status


The problem is, obviously, that calling
git reset HEAD a.txt
will result in
fatal: Failed to resolve 'HEAD' as a valid ref.

Why this is important:
New users are Going to accidentally add files they didn't mean to in  
their first trials with Git. Providing instructions guaranteed to  
error when people are just getting started with it will give git a bad  
image and hurt adoption. Also,  just about every time I've added a  
sizable project to a new version control system I've accidentally  
added a file before the first commit, usually something that should be  
added to the ignore file, but still, I think this isn't some random  
isolated problem that people never encounter.

While we're at it, can someone please explain to me how to remove a  
file from the index prior to the first commit? I'm stumped.

-masukomi
