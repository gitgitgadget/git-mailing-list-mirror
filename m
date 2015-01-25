From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 21/21] t3080: tests for git-list-files
Date: Sun, 25 Jan 2015 14:20:29 -0500
Message-ID: <CAPig+cQ8AuoA=ZNaOiZ_JQb-fKtXa-mFhoYQg+eWJxF3eFy9FA@mail.gmail.com>
References: <1422189476-7518-1-git-send-email-pclouds@gmail.com>
	<1422189476-7518-22-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 25 20:20:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YFSjv-0005SQ-V8
	for gcvg-git-2@plane.gmane.org; Sun, 25 Jan 2015 20:20:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759366AbbAYTUv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Jan 2015 14:20:51 -0500
Received: from mail-yh0-f43.google.com ([209.85.213.43]:46477 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757853AbbAYTUa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Jan 2015 14:20:30 -0500
Received: by mail-yh0-f43.google.com with SMTP id 29so2121003yhl.2
        for <git@vger.kernel.org>; Sun, 25 Jan 2015 11:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=4pRxAncvkcaXwjDmdtYqpFECkhMB/2bwgtyu69HalKw=;
        b=TA1T48DhRnV1a6TNPuKUq/xXZXqqoqeI/MJr51CW9j8tRjLmcYL7T5VKgncByU+uXH
         fsqwgZZnDF5+k1S9G7QxL7VS+6K0RBqRhz3SyDzdBPgDepmPJVWGMD157UP4JblyqER+
         Kr5eQX3uHDRDku8qzJ7g1Ho8HJFa+eJvzXYcnF2XLrv6FakpbZGEySxVSpo9VeAU3kDg
         CAQdmMh9+Liobwu6iHk0MYAQHR2LUM2QT6ITEnwgAncBRzz6Auhn/5DHBfV692nF1Tkn
         3nIVjjuZKG1TixRdxjseFdD3H8ylDws73ZsxgnQppc1D5SzCb3yKAlFsq1LLiwhSvuCO
         eXbw==
X-Received: by 10.170.136.130 with SMTP id d124mr8944954ykc.2.1422213629767;
 Sun, 25 Jan 2015 11:20:29 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Sun, 25 Jan 2015 11:20:29 -0800 (PST)
In-Reply-To: <1422189476-7518-22-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: MWsbyFPLkBkcXBw8TQGCNk1dJlU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263020>

On Sun, Jan 25, 2015 at 7:37 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/t/t3080-list-files.sh b/t/t3080-list-files.sh
> new file mode 100755
> index 0000000..6313dd9
> --- /dev/null
> +++ b/t/t3080-list-files.sh
> +test_expect_success 'no dups' '
> +       echo dirty >>file &&

To leave a clean slate for subsequent tests, would it make sense to
restore 'file' to a clean state via test_when_finished()?

> +       git list-files -m file >actual &&
> +       echo "file" >expected &&
> +       test_cmp expected actual &&
> +       git list-files -cm file >actual &&
> +       echo "C file" >expected &&
> +       test_cmp expected actual &&
> +       git list-files -tcm file >actual &&
> +       test_cmp expected actual
> +'
> +
> +test_expect_success 'diff-cached' '
> +       echo dirty >>file &&
> +       git add file &&

Ditto here?

> +       git list-files -M >actual &&
> +       echo "file" >expected &&
> +       test_cmp expected actual
> +'
