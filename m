From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v5 4/6] git-p4: add p4d timeout in tests
Date: Mon, 16 Nov 2015 08:39:53 +0000
Message-ID: <56499659.9070206@diamand.org>
References: <1447592920-89228-1-git-send-email-larsxschneider@gmail.com> <1447592920-89228-5-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: sunshine@sunshineco.com, gitster@pobox.com
To: larsxschneider@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 16 09:39:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZyFKQ-0006P4-Bi
	for gcvg-git-2@plane.gmane.org; Mon, 16 Nov 2015 09:39:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751790AbbKPIjy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2015 03:39:54 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:34094 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459AbbKPIjx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2015 03:39:53 -0500
Received: by wmvv187 with SMTP id v187so164036754wmv.1
        for <git@vger.kernel.org>; Mon, 16 Nov 2015 00:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=9XRD+AjpCWTxr0RD+TihVvrOH7wYCNKqem/vTPSPSls=;
        b=Qsv5gRwwnHRGCSXLvACU/n/jyfSv/QB9EjPd81xqulXqLyOjyteo4PgSmEZPJqnVn9
         x2k6s9EWr7pfniSNEyt0MH6AmfhGO1A4UgSy4LSOC98/LySmlaFJQ/eyjO/gt9FkXgOd
         Cp05WhcjSrxQh9TSUXtujHbEpK3qyBy/Nd6UU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=9XRD+AjpCWTxr0RD+TihVvrOH7wYCNKqem/vTPSPSls=;
        b=NiIfTucvwy4ucLrmglXBv/aEDTeiecjkg4e/HKJp1zoDZ3Di2l6dOng2BnI2Iaryc6
         2vbuysZ4wA3i4LgcMe9evSk0IrD5a5KGEGw/yAYR7bRvN5G+TsWlFl7HbUVgE6LYCfAf
         tOT0NIHWTB2Oix+VeThW2VpzQqrZxO7GwBtvd6bBpkqEvMXAYgXkvd6WLyYHkjVUtzln
         wJY1ZPw4/pQMNGY4h5zkElv4c6XakJyByU08P/rWfe+QFKjLf3nSV1KJfp+pwbyUwkMT
         EiUfuikV4wNnzGiM0vF9KkOYsqJjYLnq+9depjFxA+XjnvKk8IPGZ6RGa9+qIQGY0Vth
         UV3A==
X-Gm-Message-State: ALoCoQn16PUx/AqfbctEwRxuQQRUFMDj34Hb11lh4a0oEDxXUM2hd+qty1aPV03HRiIt4lqeRmDp
X-Received: by 10.28.156.83 with SMTP id f80mr18091109wme.41.1447663192725;
        Mon, 16 Nov 2015 00:39:52 -0800 (PST)
Received: from [192.168.245.128] (cpc12-cmbg17-2-0-cust914.5-4.cable.virginm.net. [86.30.131.147])
        by smtp.gmail.com with ESMTPSA id ft4sm33258309wjb.37.2015.11.16.00.39.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 16 Nov 2015 00:39:52 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <1447592920-89228-5-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281331>

On 15/11/15 13:08, larsxschneider@gmail.com wrote:
> From: Lars Schneider <larsxschneider@gmail.com>
>
> In rare cases p4d seems to hang. This watchdog will kill the p4d
> process after 300s in any case. That means each individual git p4 test
> needs to finish before 300s or it will fail.

Looks good to me.


>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>   t/lib-git-p4.sh | 20 +++++++++++++++++++-
>   1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
> index 8d6b48f..f2a009c 100644
> --- a/t/lib-git-p4.sh
> +++ b/t/lib-git-p4.sh
> @@ -10,6 +10,10 @@ TEST_NO_CREATE_REPO=NoThanks
>   # here the maximal retry timeout in seconds.
>   RETRY_TIMEOUT=60
>
> +# Sometimes p4d seems to hang. Terminate the p4d process automatically after
> +# the defined timeout in seconds.
> +P4D_TIMEOUT=300
> +
>   . ./test-lib.sh
>
>   if ! test_have_prereq PYTHON
> @@ -85,6 +89,19 @@ start_p4d() {
>   	# will be caught with the "kill -0" check below.
>   	i=${P4D_START_PATIENCE:-300}
>   	pid=$(cat "$pidfile")
> +
> +	timeout=$(($(date +%s) + $P4D_TIMEOUT))
> +	while true
> +	do
> +		if test $(date +%s) -gt $timeout
> +		then
> +			kill -9 $pid
> +			exit 1
> +		fi
> +		sleep 1
> +	done &
> +	watchdog_pid=$!
> +
>   	ready=
>   	while test $i -gt 0
>   	do
> @@ -145,7 +162,8 @@ kill_p4d() {
>   	retry_until_fail kill -9 $pid
>   	# complain if it would not die
>   	test_must_fail kill $pid >/dev/null 2>&1 &&
> -	rm -rf "$db" "$cli" "$pidfile"
> +	rm -rf "$db" "$cli" "$pidfile" &&
> +	retry_until_fail kill -9 $watchdog_pid
>   }
>
>   cleanup_git() {
>
