From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH v10 3/3] commit: add a commit.verbose config variable
Date: Sun, 27 Mar 2016 13:51:37 +0200
Message-ID: <1459079497-19121-1-git-send-email-szeder@ira.uka.de>
References: <01020153b478cfab-5309f834-7617-4a7f-a3e9-93f0dcf4a6be-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 27 13:52:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ak9Em-0003gC-Nd
	for gcvg-git-2@plane.gmane.org; Sun, 27 Mar 2016 13:52:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442AbcC0Lv7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Mar 2016 07:51:59 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:43768 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751353AbcC0Lv6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Mar 2016 07:51:58 -0400
Received: from x590d8713.dyn.telefonica.de ([89.13.135.19] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1ak9EX-0003Gj-Ub; Sun, 27 Mar 2016 13:51:56 +0200
X-Mailer: git-send-email 2.8.0.rc3.58.gc805582
In-Reply-To: <01020153b478cfab-5309f834-7617-4a7f-a3e9-93f0dcf4a6be-000000@eu-west-1.amazonses.com>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1459079516.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290002>

> +test_expect_success 'commit.verbose true and --no-verbose' '
> +	git -c commit.verbose=true commit --amend --no-verbose &&
> +	! test -s out

Please use the test_must_be_empty helper instead, because it has a
nice, human-readable name and it complains with a helpful error
message if something goes wrong, whereas 'test -s' just fails
silently.

> +'
> +
> +test_expect_success 'commit.verbose false and --verbose' '
> +	git -c commit.verbose=false commit --amend --verbose &&
> +	test_line_count = 1 out
> +'
> +
> +test_expect_success 'commit.verbose false and -v -v' '
> +	git -c commit.verbose=false commit --amend -v -v &&
> +	test_line_count = 2 out
> +'
> +
> +test_expect_success 'commit.verbose false and --verbose omitted' '
> +	git -c commit.verbose=false commit --amend &&
> +	! test -s out
> +'
> +
> +test_expect_success 'commit.verbose false and --no-verbose' '
> +	git -c commit.verbose=false commit --amend --no-verbose &&
> +	! test -s out
> +'
> +
> +test_expect_success 'status ignores commit.verbose=true' '
> +	git -c commit.verbose=true status >actual &&
> +	! grep "^diff --git" actual
> +'
> +
>  test_done
> 
> --
> https://github.com/git/git/pull/218
> 
> 
