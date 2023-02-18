Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F33C61DA4
	for <git@archiver.kernel.org>; Sat, 18 Feb 2023 17:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjBRRLM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Feb 2023 12:11:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBRRLK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Feb 2023 12:11:10 -0500
Received: from omta001.cacentral1.a.cloudfilter.net (omta001.cacentral1.a.cloudfilter.net [3.97.99.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB0B1716C
        for <git@vger.kernel.org>; Sat, 18 Feb 2023 09:11:04 -0800 (PST)
Received: from shw-obgw-4001a.ext.cloudfilter.net ([10.228.9.142])
        by cmsmtp with ESMTP
        id T5FDpQbZkuZMSTQjnpgFgo; Sat, 18 Feb 2023 17:11:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=shaw.ca; s=s20180605;
        t=1676740263; bh=/aUAoHlBBtXRg9I9gW/fG36fWSJ2ZMpKAnMTbZ16mFc=;
        h=Date:Reply-To:Subject:To:References:Cc:From:In-Reply-To;
        b=D96Fi6xo1IjXSBkkNMm3LxPwKmNUCpObHbr81OxxQsXxoJyn1Hh7IETJ8jOmg7NOb
         Az0bHK/Vn10Dd8RTXAZal9VPMeTlTDe2CLBfdInMgnxp+jghndunHD82thj0LsRWDg
         swI0e/UayCgwFGEZNxsdSXFjFPVvTnOtZYc1jA7E4xYkksJQs8bQXlzJfXDWDl4w+6
         BpOKwusd5aNqU21z81v0j4d+NObeJ8u5sPpziG48uuyNvINlrRKZw/ivddFgwHvjC/
         9+YSVId+dvyLKaegNL+aw5wuWacvfpX6IZKYrRKu77CaHkGT52ykIY+/5cPp9ItZcK
         PJ/krabUl+53Q==
Received: from [10.0.0.5] ([184.64.102.149])
        by cmsmtp with ESMTP
        id TQjnppC4nHFsOTQjnpZSaa; Sat, 18 Feb 2023 17:11:03 +0000
X-Authority-Analysis: v=2.4 cv=XZqaca15 c=1 sm=1 tr=0 ts=63f106a7
 a=DxHlV3/gbUaP7LOF0QAmaA==:117 a=DxHlV3/gbUaP7LOF0QAmaA==:17
 a=IkcTkHD0fZMA:10 a=ybZZDoGAAAAA:8 a=lrZlElB6y-Ld5Czf_sYA:9 a=QEXdDO2ut3YA:10
 a=0RhZnL1DYvcuLYC8JZ5M:22
Message-ID: <b2866322-5654-15d0-df83-a87926a01815@Shaw.ca>
Date:   Sat, 18 Feb 2023 10:11:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Reply-To: Brian.Inglis@Shaw.ca
Subject: Re: [PATCH] format.attach: allow empty value to disable multi-part
 messages
Content-Language: en-CA
To:     Junio C Hamano <gitster@pobox.com>
References: <xmqqwn4fkgtq.fsf@gitster.g>
Cc:     git@vger.kernel.org
From:   Brian Inglis <Brian.Inglis@Shaw.ca>
Organization: Inglis
In-Reply-To: <xmqqwn4fkgtq.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfEvBLnA14H5b6+9NX/96VG58cJ/QkO6f2aKasJWzt8L19dS+kBmE/F2XlOxupizDo+/beBMZT5yCtBYyixU0JxT81xBVGozTgJIrbqeJGAcXAe2uMuWB
 nR3VSLafa8rqiG6CVGfi+RHFqg4PHUGbHSvUaPTkij3KpmQseQVgM0BSd0YIA8k7UoBjyreyOVfgmDPwXbrnmZH2lpYtK/EL9Ng=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Junio,

I'll hope and watch for it to get added, and test if/when released.

-- 
Take care. Thanks, Brian Inglis			Calgary, Alberta, Canada

La perfection est atteinte			Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter	not when there is no more to add
mais lorsqu'il n'y a plus rien à retirer	but when there is no more to cut
			-- Antoine de Saint-Exupéry


On 2023-02-17 16:33, Junio C Hamano wrote:
> When a lower precedence configuration file (e.g. /etc/gitconfig)
> defines format.attach in any way, there was no way to disable it in
> a more specific configuration file (e.g. $HOME/.gitconfig).
> 
> Change the behaviour of setting it to an empty string.  It used to
> mean that the result is still a multipart message with only dashes
> used as a multi-part separator, but now it resets the setting to
> the default (which would be to give an inline patch, unless other
> command line options are in effect).
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>   * This is a backward incompatible change, so we may not take it in the
>     end.  We'll see.
> 
>   Documentation/config/format.txt |  3 ++-
>   builtin/log.c                   |  2 ++
>   t/t4014-format-patch.sh         | 18 ++++++++++++++++++
>   3 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/config/format.txt b/Documentation/config/format.txt
> index 3bd78269e2..73678d88a1 100644
> --- a/Documentation/config/format.txt
> +++ b/Documentation/config/format.txt
> @@ -3,7 +3,8 @@ format.attach::
>   	'format-patch'.  The value can also be a double quoted string
>   	which will enable attachments as the default and set the
>   	value as the boundary.  See the --attach option in
> -	linkgit:git-format-patch[1].
> +	linkgit:git-format-patch[1].  To countermand an earlier
> +	value, set it to an empty string.
>   
>   format.from::
>   	Provides the default value for the `--from` option to format-patch.
> diff --git a/builtin/log.c b/builtin/log.c
> index 04412dd9c9..a70fba198f 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -1007,6 +1007,8 @@ static int git_format_config(const char *var, const char *value, void *cb)
>   	if (!strcmp(var, "format.attach")) {
>   		if (value && *value)
>   			default_attach = xstrdup(value);
> +		else if (value && !*value)
> +			FREE_AND_NULL(default_attach);
>   		else
>   			default_attach = xstrdup(git_version_string);
>   		return 0;
> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index 012f155e10..f3313b8c58 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -2281,6 +2281,24 @@ test_expect_success 'format-patch --attach cover-letter only is non-multipart' '
>   	test_line_count = 1 output
>   '
>   
> +test_expect_success 'format-patch with format.attach' '
> +	test_when_finished "rm -fr patches" &&
> +	separator=attachment-separator &&
> +	test_config format.attach "$separator" &&
> +	filename=$(git format-patch -o patches -1) &&
> +	grep "^Content-Type: multipart/.*$separator" "$filename"
> +'
> +
> +test_expect_success 'format-patch with format.attach=disabled' '
> +	test_when_finished "rm -fr patches" &&
> +	separator=attachment-separator &&
> +	test_config_global format.attach "$separator" &&
> +	test_config format.attach "" &&
> +	filename=$(git format-patch -o patches -1) &&
> +	# The output should not even declare content type for text/plain.
> +	! grep "^Content-Type: multipart/" "$filename"
> +'
> +
>   test_expect_success '-c format.mboxrd format-patch' '
>   	sp=" " &&
>   	cat >msg <<-INPUT_END &&
