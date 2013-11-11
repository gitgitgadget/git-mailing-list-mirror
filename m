From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: [PATCH 2/7] test-bzr.sh, test-hg.sh: allow running from any dir
Date: Mon, 11 Nov 2013 05:35:36 -0600
Message-ID: <5280c108749d8_6841541e787e@nysa.notmuch>
References: <1384142712-2936-1-git-send-email-rhansen@bbn.com>
 <1384142712-2936-3-git-send-email-rhansen@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: felipe.contreras@gmail.com, Richard Hansen <rhansen@bbn.com>
To: Richard Hansen <rhansen@bbn.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 11 12:43:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VfpuA-0003DD-Op
	for gcvg-git-2@plane.gmane.org; Mon, 11 Nov 2013 12:43:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752910Ab3KKLnj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 06:43:39 -0500
Received: from mail-ob0-f176.google.com ([209.85.214.176]:44396 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752616Ab3KKLni (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 06:43:38 -0500
Received: by mail-ob0-f176.google.com with SMTP id wp4so2879874obc.21
        for <git@vger.kernel.org>; Mon, 11 Nov 2013 03:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=SasN4fIMhxCxOB6CRoWqY/C4FGoL1LpHW2makJ9Ctzs=;
        b=FQHwKMKkH0mjugu5TmbFhQ24KT00RQ9N62iQAY1y8ive5j2R639bLSgTzFXFA3esph
         6AFQuqlvCupsG8YPmBCqB9bon4Z6ZvRuNtn7/oLTrm/9AyX4DQiUA9Vjl3Ztb/7y1FX+
         ba6433B0W0HsYghycgTA4g5BryKfjBywKzMnIW6geXCT9tSM3UjLDXek2A9VYmSf4vGp
         82V3gxegMEmAcqs+f4P/SVM7akxAOk5yzrqnEmNVEtRmebX4e7d4mOFnWjql3zXQhtct
         1c188NjHmubpTURqkgphC7CXqUXS9vnHWTSoX5m3sMqjdQUgTJmkchASB7bVb3zqwnKQ
         yRoA==
X-Received: by 10.60.137.193 with SMTP id qk1mr559653oeb.89.1384170217952;
        Mon, 11 Nov 2013 03:43:37 -0800 (PST)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id it7sm25730580obb.11.2013.11.11.03.43.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Nov 2013 03:43:37 -0800 (PST)
In-Reply-To: <1384142712-2936-3-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237609>

Richard Hansen wrote:
> cd to the t/ subdirectory so that the user doesn't already have to be
> in the test directory to run these test scripts.
> 
> Signed-off-by: Richard Hansen <rhansen@bbn.com>
> ---
>  contrib/remote-helpers/test-bzr.sh | 1 +
>  contrib/remote-helpers/test-hg.sh  | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/contrib/remote-helpers/test-bzr.sh b/contrib/remote-helpers/test-bzr.sh
> index 5c50251..094062c 100755
> --- a/contrib/remote-helpers/test-bzr.sh
> +++ b/contrib/remote-helpers/test-bzr.sh
> @@ -5,6 +5,7 @@
>  
>  test_description='Test remote-bzr'
>  
> +cd "${0%/*}"/../../t || exit 1

I think this should do the trick:

  test -z "$TEST_DIRECTORY" && TEST_DIRECTORY="$(realpath ${0%/*}/../../t)"
  . "$TEST_DIRECTORY"/test-lib.sh

-- 
Felipe Contreras
