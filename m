From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCHv5 1/2] http.c: implement the GIT_TRACE_CURL environment
 variable
Date: Mon, 2 May 2016 18:03:51 +0100
Message-ID: <57278877.50907@ramsayjones.plus.com>
References: <20160502142813.50868-1-gitter.spiros@gmail.com>
 <20160502142813.50868-2-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: tboegi@web.de, gitster@pobox.com, sunshine@sunshineco.com,
	peff@peff.net
To: Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 02 19:04:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axHGT-0007OQ-I5
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 19:04:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754198AbcEBREG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 13:04:06 -0400
Received: from avasout07.plus.net ([84.93.230.235]:38227 "EHLO
	avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753598AbcEBRED (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 13:04:03 -0400
Received: from [10.0.2.15] ([91.125.197.102])
	by avasout07 with smtp
	id pV3v1s0022D2Veb01V3woN; Mon, 02 May 2016 18:04:00 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=QqujpgGd c=1 sm=1 tr=0
 a=mTUfFwB0nGOO66Ym8a+i3w==:117 a=mTUfFwB0nGOO66Ym8a+i3w==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=0UNnMH9RAlEhWUKK-JsA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
In-Reply-To: <20160502142813.50868-2-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293242>



On 02/05/16 15:28, Elia Pinto wrote:

[snip]

> diff --git a/http.h b/http.h
> index 36f558b..cd186a4 100644
> --- a/http.h
> +++ b/http.h
> @@ -225,4 +225,8 @@ extern int finish_http_object_request(struct http_object_request *freq);
>  extern void abort_http_object_request(struct http_object_request *freq);
>  extern void release_http_object_request(struct http_object_request *freq);
>  
> +/* Debug callback and setup routine for curl_easy_setopt CURLOPT_DEBUGFUNCTION */
> +void setup_curl_trace(CURL *handle);
> +int curl_trace(CURL *handle, curl_infotype type, char *data, size_t size, void *userp);

Given that you have wrapped the use of the debug callback into the
setup_curl_trace() routine (good), do you still need to export the
curl_trace() function?

I would make that static, so that only setup_curl_trace() needs to
be a public symbol. (I would also re-order the function definitions,
so that setup_curl_trace() comes after curl_trace(), but that is a
minor point).

ATB,
Ramsay Jones
