Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFECECAAD8
	for <git@archiver.kernel.org>; Wed, 21 Sep 2022 22:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbiIUWYo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Sep 2022 18:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiIUWYm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2022 18:24:42 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-oln040092075057.outbound.protection.outlook.com [40.92.75.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D92A201BC
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 15:24:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k8flrdehVicbCFGTIotMs3IEVrvFepg+n8j1Ez1D7djm4gqDF0KQzzTUii+YxvmQxgAU6mecMB5QocDAazvmhDFhYWi4J8ovdrVEC4mE6vTVj5M/ryTk4SjoIBEA4efUdOeu4cepuM3EqB1gJb7e29+AExZhNftP1hrY+puiccQckGMTExvfw8C49fvPt8gyXqnB0gFcUrI/UBFhI4TDAQ/wiiOWt2oYxTN6DRol71oZzkXhRMZsJHHY/bf+cGc2JYG1+KXkzA9NbvVJI68ShpWX1FWMZ5YKX/iaKASfYTESZBfmsW9YYDwsUMNbbeBrDusNpXampMMWeRDNhbXwJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6cKwQ/MA13jQmOaFX82KM2AroRoebYICEp4HPAmp1Fs=;
 b=GRpcglxlf17FHrdiiWMch2gxQo2AgG+eZpyvDi+x0JSpqerwEDK0DBqhv2xRzGcFg+9yJ9VmbNqSML/LbXi7nscREG6TzTOiyHr8RkbbAps1OsiOyMio4siFhLyxEy1yYFba5UyLLoLCZuLsJL3vmdeqgjsSDXVclS1O1F8L1UsjY8kzpyXuqPVyE36xMTSrAVywj2O8nKpGzUnWo0zYspCYaHQU4pATtk07nisZMdy+vZ3S2YSgUrfULcXEVn0sB6zFK0hMVcQqiCPZX363c/zJ3OI88f45RHwaPuMrypMKS7X/Y2JEQb+cg2q79JhozUkh521ku9M8ObgaU5TjfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cKwQ/MA13jQmOaFX82KM2AroRoebYICEp4HPAmp1Fs=;
 b=sX4JJDj0mtqymwKjxx+z3hfy5a2TnWSR9aaYXDeM9ULgMpp6v8jvJAVYXrlV4h/EuBeHBSHIssYAL6zAhKQTK1cY+sZ+D8ZTqqK+r96DJefbl35e+EUVX5Cd4g77Cy63pfE3oEa4/v7D2l1jsBeRlIjyu5I/ojylqWfOId+FDVWN6J18/WgHTnZqWvShzlv9wuvAfxe5e+PMHxpEbn8/uUbFn469tzmDxwgGwUY4So996N4iN/CIaph/MMB2hrUDD9SQWhky8/ViZUlzu0H9kRajBrh8nggzjCTJ+PcPZ7O3QRRtJMlddqYNhaEL1fuQFrHSKrahKxu8o6LWOd2IqQ==
Received: from AS8PR03MB8689.eurprd03.prod.outlook.com (2603:10a6:20b:54e::12)
 by DU0PR03MB8416.eurprd03.prod.outlook.com (2603:10a6:10:3b8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.17; Wed, 21 Sep
 2022 22:24:37 +0000
Received: from AS8PR03MB8689.eurprd03.prod.outlook.com
 ([fe80::10:9a9a:64a9:612d]) by AS8PR03MB8689.eurprd03.prod.outlook.com
 ([fe80::10:9a9a:64a9:612d%4]) with mapi id 15.20.5632.021; Wed, 21 Sep 2022
 22:24:37 +0000
Message-ID: <AS8PR03MB8689A10E534EC69BB71AEA56C04F9@AS8PR03MB8689.eurprd03.prod.outlook.com>
Date:   Wed, 21 Sep 2022 15:24:31 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH 4/8] http: read HTTP WWW-Authenticate response headers
To:     Derrick Stolee <derrickstolee@github.com>,
        Matthew John Cheetham via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
References: <pull.1352.git.1663097156.gitgitgadget@gmail.com>
 <78e66d56605cfb1c7000edf329ac16c05a5d69b0.1663097156.git.gitgitgadget@gmail.com>
 <9fded44b-c503-f8e5-c6a6-93e882d50e27@github.com>
From:   Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <9fded44b-c503-f8e5-c6a6-93e882d50e27@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN:  [qwsv297btZvCURT2eET//pesFDqNHAL3G+0L641TwEx5xnzgT403tzqTzYmYkCP0]
X-ClientProxiedBy: SJ0PR05CA0158.namprd05.prod.outlook.com
 (2603:10b6:a03:339::13) To AS8PR03MB8689.eurprd03.prod.outlook.com
 (2603:10a6:20b:54e::12)
X-Microsoft-Original-Message-ID: <e7ba3cd3-1ee9-2962-867b-d6481dd7cae5@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR03MB8689:EE_|DU0PR03MB8416:EE_
X-MS-Office365-Filtering-Correlation-Id: f3fa1669-d13e-40ca-4288-08da9c201152
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RRdNQT08mlW2oBYYQUI0zUHTiqwsYzlsSeMVEHXhpJrGW99f6ZrJlQJrRyy5mVi61+zHZJJoukRhxGhGJ/6Yb44Kvxaa/xARYELESzSQFflXOTeZheGYwpsUXVnysChjCYQOPYXrwyg6DZyN3mWPMbzBWDz/0l4//ft+a1IETtBlZZbKtKGhbnIroBnfiCZUf76dBHqV1PuRK4brUaj9UJVXd4GVDNI4UHW4yqXA7XnzXFptlnhI3MC/JaEtwg2izcQa5Aw2KlNyr2bh8wznSEyzY9otN7RRgB0bG9efSUxixRAF/EYkniZRQhHN75EzMHc1asf8dUbx/z3A08hdYmOG/c9xBSkpw9z5aeIqNz3CEwXNit59Mr+n30YCLUwAd91rSINo0eg/qVGK7b3iPjwgJ8oY9DYaJBqfIXJJfigRQjn6f3bFRc2K/gH79rPg6lXB0DiKg51mtkwJFH/wfOtD1sFg9ZVdPGvvnjsBhzFTyWGofWLKVR/LKJJ62nUpiMcMKUyVM1Y+L7iUKwd+EgIZ+fLRl0baopyiWMfW8Ea3NaOCjReoFhEqmQSGQqqYdYAwxp3wLJWd1AiAdexb/xKi6nOGt0hBtBbhflzBRLgk7mRofg2TcjugE1S7+HQgrLo7xW3NMLbDgtrjVtPtLnc43B9kV48riEwGmgeuREwMS8p8TsVdhRtTfvkHTatm
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUpjUjBlc0dWeU50c3NnOENnR0R4ZFZnc09NZS9wbGREdGZydWhGNGNuWjA0?=
 =?utf-8?B?a2VuZ2t0d3lQKytHZElBa2RhUktmVnB5akZxd0hVeUxINHVWMkpkZjJVRUc2?=
 =?utf-8?B?cW9jSFM4RE9GdXluUUVxalU4OHRGRXdEK0xDUG9wa3k0QXBLQURZeElpL0VG?=
 =?utf-8?B?cW1kODI5dWlKUTJocCt5dVRwV2ZLRXpxcnUzdTg1ZkFla1pHbzNVdHViMmlD?=
 =?utf-8?B?NGpLczdKTlRRbCtnWXBlWmxiUldkKzV0UzFrdlorR25CcHNLODZybWdDSXlw?=
 =?utf-8?B?M0s1aldzZWVKelA4dm82Q3Zya3lvR0hTaTk1NUtSbXlDeFphcHBSUlM5YjZM?=
 =?utf-8?B?T3hWQ0ljRzM2WTVvTWFCOEZzYzQ1a1pvUGNCWUJxUzFUNFprWkpDY3djdkVs?=
 =?utf-8?B?WnBycmtNY0REVTBTcWpMR1A0VHg3U2FpMmhkK3VYUklWWmEwT21NK3QxMDZk?=
 =?utf-8?B?cWZ4aEc3TS9lYjAxbHRVb2F1ZnVSM1oyelRITjh3ejcyWkxlZUlZQ0ZNNktu?=
 =?utf-8?B?T1Z4WjJQbWdWTjBDUWFFR3VPSnpaU3VrWUhZU0VGWHJaZkZYS2tweHpYbDBo?=
 =?utf-8?B?SWJiekZodVNRcHpmMFFRZVdQc0FZSGxPMVFDQjhGeEtIc2pkOHZyWU5kNzZV?=
 =?utf-8?B?cmZuU05mMytxZit3S0dJWCs1cWFxM3g3dUhaSE1aQ3Z2NEdtZ2ZZa2NTUldj?=
 =?utf-8?B?MDY3NUVURGEwb043dGFFejhhbjg3ZzMwc2krTlY0d0taRi85VVNaY3VzMGFZ?=
 =?utf-8?B?eTFqRWtWZGZaN29DR0dkMGNsQUJ1SzN5eUlNOXI4RnpvM2JzeU5ZTVkwcGZ1?=
 =?utf-8?B?djJ1WWJHeFR6ZmxXRm92ZVhlVzNUVkZGOG1UTGJCUm1aWE9acE9ZVlJNdWNU?=
 =?utf-8?B?VW5qWTlCWTBNZ0xSMmU3QXJ2UlBIY01XTVpNdnZTQ0RoeFluVmRMVzdjaDIy?=
 =?utf-8?B?YTMzZGxIR29LbHdITGpmTWhTTGVwOFZhMWZvSExGRTJSakErZSt6ZTc5eVg4?=
 =?utf-8?B?MmF0RTJUem1nQWp3ajMwbUlYTXA1Wm1PN0VkUXhrMnA0MnBQV3VlZTBkT0FI?=
 =?utf-8?B?SzZtVUxVSkV0NnBjcFJLMG0wSnlDbmJJcDhUZTgrM0hSZzhFL3A5dXpXZzBC?=
 =?utf-8?B?TU94VGlaRE8wbWtzbHJ6dFdqbHR5VkIycmw4YXFucU5wd3JZcVg4d1plWGIw?=
 =?utf-8?B?aXNORFArdkpoYmlOR1VTSjRNSUhKWFgzN1EreGQwcFc1TTI5bC9KNzkybWhz?=
 =?utf-8?B?bjJOWStxMUdPLzZvT0wwNTBXQmQ1MktqVlVPTTZxUFNKVkdXcDdoaVVPNG1U?=
 =?utf-8?B?VC8rUGJ1YldSZkhzeFVpU0VzMWF3K2FxdjJGRkdIc29MSm13akIreXh1M01X?=
 =?utf-8?B?dU5BZzhyZU44eGdJK2lDNGluVG4wVDN5ZE9uTkwyN2VVWGtIem5lUmpFbDVn?=
 =?utf-8?B?Q1JDR0h3eDR5MDZUUkRYSWQ4eXF2bnhLbGU2VFlPSHFpMDBFcmxjVXlZZGda?=
 =?utf-8?B?K3Z6UnNIR3phdlN6UmtTK3dxcFBzU1YvRzZKZk1pRTQrNUtXTTVYOGxDeU1S?=
 =?utf-8?B?R0Z2K0xFdTBRcW8vNVRaNUlISGdLYnBGT3pyR3hlMUJ4UkxkS2FITUZvZlZ6?=
 =?utf-8?B?bXAwL0tHbUFJQUNaa2w2dzZHU04vSzF3bExSaEN1TGhrTW5nYmplK1lpc0l2?=
 =?utf-8?B?UVdsL1p2OHBUOE0vam1nTEVUVjBYV1dtS0piK3EySElvYTZpSHJ0cGJoOExT?=
 =?utf-8?B?djFpRXJodlhSbzJkYlJLZEhlU2VKZ0xreW9TT3NGdkpFTmdsdjVmNUQzaDBP?=
 =?utf-8?B?b1lib3ljVTVnOFZORTZLUT09?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3fa1669-d13e-40ca-4288-08da9c201152
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB8689.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 22:24:37.4638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB8416
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-09-19 09:21, Derrick Stolee wrote:
> On 9/13/2022 3:25 PM, Matthew John Cheetham via GitGitGadget wrote:
> 
>> +	/**
>> +	 * A `strvec` of WWW-Authenticate header values. Each string
>> +	 * is the value of a WWW-Authenticate header in an HTTP response,
>> +	 * in the order they were received in the response.
>> +	 */
>> +	struct strvec wwwauth_headers;
> 
> I like this careful documentation.
> 
>> +	unsigned header_is_last_match:1;
> 
> But then this member is unclear how it is attached. It could use its
> own "for internal use" comment if we don't want to describe it in full
> detail here.

A fair point. I will update in a future iteration.

>> +static size_t fwrite_wwwauth(char *ptr, size_t eltsize, size_t nmemb, void *p)
>> +{
>> +	size_t size = eltsize * nmemb;
>> +	struct strvec *values = &http_auth.wwwauth_headers;
>> +	struct strbuf buf = STRBUF_INIT;
>> +	const char *val;
>> +	const char *z = NULL;
>> +
>> +	/*
>> +	 * Header lines may not come NULL-terminated from libcurl so we must
>> +	 * limit all scans to the maximum length of the header line, or leverage
>> +	 * strbufs for all operations.
>> +	 *
>> +	 * In addition, it is possible that header values can be split over
>> +	 * multiple lines as per RFC 2616 (even though this has since been
>> +	 * deprecated in RFC 7230). A continuation header field value is
>> +	 * identified as starting with a space or horizontal tab.
>> +	 *
>> +	 * The formal definition of a header field as given in RFC 2616 is:
>> +	 *
>> +	 *   message-header = field-name ":" [ field-value ]
>> +	 *   field-name     = token
>> +	 *   field-value    = *( field-content | LWS )
>> +	 *   field-content  = <the OCTETs making up the field-value
>> +	 *                    and consisting of either *TEXT or combinations
>> +	 *                    of token, separators, and quoted-string>
>> +	 */
>> +
>> +	strbuf_add(&buf, ptr, size);
>> +
>> +	/* Strip the CRLF that should be present at the end of each field */
> 
> Is it really a CRLF? Or just an LF?

It is indeed an CRLF, agnostic of platform. HTTP defines CRLF as the
end-of-line marker for all entities other than the body.

See RFC 2616 section 2.2: https://www.rfc-editor.org/rfc/rfc2616#section-2.2

>> +	strbuf_trim_trailing_newline(&buf);
> 
> Thankfully, this will trim an LF _or_ CR/LF pair, so either way would be fine.
> 
>> +	/* Start of a new WWW-Authenticate header */
>> +	if (skip_iprefix(buf.buf, "www-authenticate:", &val)) {
>> +		while (isspace(*val)) val++;
> 
> Break the "val++;" to its own line:
> 
> 		while (isspace(*val))
> 			val++;

Sure! Sorry I missed this one.

> While we are here, do we need to be careful about the end of the string at
> this point? Is it possible that the server will send all spaces up until the
> maximum header size (as mentioned in the message)?
> 
>> +
>> +		strvec_push(values, val);
>> +		http_auth.header_is_last_match = 1;
>> +		goto exit;
>> +	}
>> +
>> +	/*
>> +	 * This line could be a continuation of the previously matched header
>> +	 * field. If this is the case then we should append this value to the
>> +	 * end of the previously consumed value.
>> +	 */
>> +	if (http_auth.header_is_last_match && isspace(*buf.buf)) {
>> +		const char **v = values->v + values->nr - 1;
> 
> I suppose we expect leading spaces as critical to this header, right?

Leading (and trailing) spaces are not part of the header value.

From RFC 2616 section 2.2 regarding header field values:

"All linear white space, including folding, has the same semantics as SP.
A recipient MAY replace any linear white space with a single SP before
interpreting the field value or forwarding the message downstream."

>> +		char *append = xstrfmt("%s%.*s", *v, (int)(size - 1), ptr + 1);
> 
> We might have better luck using a strbuf, initializing it with the expected
> size and using strbuf_add() to append the strings. Maybe I'm just prematurely
> optimizing, though.

This code path is used to re-join/fold a header value continuation, which is
pretty rare in the wild (if at all with modern web servers).

>> +
>> +		free((void*)*v);
>> +		*v = append;
>> +
>> +		goto exit;
>> +	}
>> +
>> +	/* This is the start of a new header we don't care about */
>> +	http_auth.header_is_last_match = 0;
>> +
>> +	/*
>> +	 * If this is a HTTP status line and not a header field, this signals
>> +	 * a different HTTP response. libcurl writes all the output of all
>> +	 * response headers of all responses, including redirects.
>> +	 * We only care about the last HTTP request response's headers so clear
>> +	 * the existing array.
>> +	 */
>> +	if (skip_iprefix(buf.buf, "http/", &z))
>> +		strvec_clear(values);
>> +
>> +exit:
>> +	strbuf_release(&buf);
>> +	return size;
>> +}
>> +
>>  size_t fwrite_null(char *ptr, size_t eltsize, size_t nmemb, void *strbuf)
>>  {
>>  	return nmemb;
>> @@ -1829,6 +1904,8 @@ static int http_request(const char *url,
>>  					 fwrite_buffer);
>>  	}
>>  
>> +	curl_easy_setopt(slot->curl, CURLOPT_HEADERFUNCTION, fwrite_wwwauth);
> 
> Nice integration point!
> 
> Thanks,
> -Stolee

Thanks,
Matthew
