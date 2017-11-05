Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32E5220281
	for <e@80x24.org>; Sun,  5 Nov 2017 13:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752522AbdKENVL (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Nov 2017 08:21:11 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:50990 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752078AbdKENVK (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 5 Nov 2017 08:21:10 -0500
X-AuditID: 1207440c-7fdff7000000143e-7f-59ff1043b4cb
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id E6.3C.05182.4401FF95; Sun,  5 Nov 2017 08:21:08 -0500 (EST)
Received: from [192.168.69.190] (p4FC6E019.dip0.t-ipconnect.de [79.198.224.25])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id vA5DL3Tc026007
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sun, 5 Nov 2017 08:21:05 -0500
Subject: Re: [PATCH v1 1/2] refs: extract function to normalize partial refs
To:     Kevin Daudt <me@ikke.info>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, hjemli@gmail.com, pclouds@gmail.com,
        ilari.liusvaara@elisanet.fi,
        =?UTF-8?Q?Rafael_Ascens=c3=a3o?= <rafa.almas@gmail.com>
References: <20171104224511.22609-1-me@ikke.info>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <21ec16d1-cca1-0f6d-f389-b64de91dcef3@alum.mit.edu>
Date:   Sun, 5 Nov 2017 14:21:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171104224511.22609-1-me@ikke.info>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRmVeSWpSXmKPExsUixO6iqOsq8D/SYNpxJouuK91MFg29V5gt
        ls56w2ixcs0eZotXHe2MFt1T3jJafDp4k8WB3WPl2VqPnbPusnv8uvuSzePiJWWPz5vkAlij
        uGxSUnMyy1KL9O0SuDK6/81mLWgXqrj5fR9bA+Mivi5GTg4JAROJhvP9rF2MXBxCAjuYJJ5P
        WccM4Zxjktj87AEbSJWwgI/E3QndYLaIgJPEyu//WECKmAWWMUoc2/2HESQhJGAocW73UhYQ
        m01AV2JRTzMTiM0rYC+x/XQXWA2LgIpE+8RNYDWiAhESz5vfs0LUCEqcnPkELM4pYCSx9ucZ
        sGXMAuoSf+ZdYoawxSVuPZnPBGHLS2x/O4d5AqPALCTts5C0zELSMgtJywJGllWMcok5pbm6
        uYmZOcWpybrFyYl5ealFuoZ6uZkleqkppZsYIfHAs4Px2zqZQ4wCHIxKPLwnPP5FCrEmlhVX
        5h5ilORgUhLlvfLyT6QQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEd6gxUDlvCmJlVWpRfkwKWkO
        FiVxXtUl6n5CAumJJanZqakFqUUwWRkODiUJXjP+/5FCgkWp6akVaZk5JQhpJg5OkOE8QMP1
        QGp4iwsSc4sz0yHypxh1OZ7NfN3ALMSSl5+XKiXOe50PqEgApCijNA9uDiyNvWIUB3pLmNcQ
        ZBQPMAXCTXoFtIQJaMlsjj8gS0oSEVJSDYwV1SsMlEQ416772V+vKbai1PDG1H1nSpp5X4bm
        aDDf/O3QbNbs9t196u7LuzTl95od+vzc1VW3l2tXS0n3MvmQzEqp1LKIZS0cIZVB77lzN/1V
        DF5oz63747dB5sT7P/LV9X/LH7+94ZhbweOTlndPbUm/cMj2LJfXufzGG3OXWxx0aO+q/KjE
        UpyRaKjFXFScCADfogwqPgMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/04/2017 11:45 PM, Kevin Daudt wrote:
> On Sat, Nov 04, 2017 at 11:27:39AM +0900, Junio C Hamano wrote:
>> I however notice that addition of /* to the tail is trying to be
>> careful by using strbuf_complete('/'), but prefixing with "refs/"
>> does not and we would end up with a double-slash if pattern begins
>> with a slash.  The contract between the caller of this function (or
>> its original, which is for_each_glob_ref_in()) and the callee is
>> that prefix must not begin with '/', so it may be OK, but we might
>> want to add "if (*pattern == '/') BUG(...)" at the beginning.
>>
>> I dunno.  In any case, that is totally outside the scope of this two
>> patch series.
> 
> I do think it's a good idea to make future readers of the code aware of
> this contract, and adding a BUG assert does that quite well. Here is a
> patch that implements it.
> 
> This applies of course on top of this patch series.
> 
> -- >8 --
> Subject: [PATCH] normalize_glob_ref: assert implicit contract of prefix
> 
> normalize_glob_ref has an implicit contract of expecting 'prefix' to not
> start with a '/', otherwise the pattern would end up with a
> double-slash.
> 
> Mark it as a BUG when the prefix argument of normalize_glob_ref starts
> with a '/' so that future callers will be aware of this contract.
> 
> Signed-off-by: Kevin Daudt <me@ikke.info>
> ---
>  refs.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/refs.c b/refs.c
> index e9ae659ae..6747981d1 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -372,6 +372,8 @@ int head_ref_namespaced(each_ref_fn fn, void *cb_data)
>  void normalize_glob_ref(struct strbuf *normalized_pattern, const char *prefix,
>  		const char *pattern, int flags)
>  {
> +	if (prefix && *prefix == '/') BUG("prefix cannot not start with '/'");

This should be split onto two lines.

Also, "prefix cannot not start ..." has two "not". I suggest changing it
to "prefix must not start ...", because that makes it clearer that the
caller is at fault.

What if the caller passes the empty string as prefix? In that case, the
end result would be "/<pattern>", which is also bogus.

> +
>  	if (!prefix && !starts_with(pattern, "refs/"))
>  		strbuf_addstr(normalized_pattern, "refs/");
>  	else if (prefix)

Michael
