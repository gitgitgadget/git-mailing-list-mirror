From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 1/2] imap-send.c: implements the GIT_CURL_DEBUG
 environment variable
Date: Fri, 1 Apr 2016 13:44:28 +0200
Message-ID: <56FE5F1C.2040103@web.de>
References: <1459507482-36678-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 01 13:44:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alxVF-0004O8-F4
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 13:44:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755220AbcDALod (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 07:44:33 -0400
Received: from mout.web.de ([212.227.17.11]:57628 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752606AbcDALoc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 07:44:32 -0400
Received: from birne9.local ([195.252.60.88]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0MJl1M-1akr2P1aMe-0017lD; Fri, 01 Apr 2016 13:44:29
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:38.0)
 Gecko/20100101 Thunderbird/38.6.0
In-Reply-To: <1459507482-36678-1-git-send-email-gitter.spiros@gmail.com>
X-Provags-ID: V03:K0:kdCR5zP8sDeI7MbM3yu7v8qbEBgVOLyOE8Z5gQvQ8qiv3Pn7qGW
 V0WFM/jbtovurSUHSb7Ga6G5EAdWqzA5/LLHBU3RmVPvPOv2+GI1LTfM9+OdGEOeyoa6oOT
 Ym/NlmqQ9a4xuYaLxl4Y94dqstEOf0Bfb4lQBeLgqGfskIBM3JqsSve3FcQXydNOZWVvR+0
 YL043BByoRj7KElkus6ZA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:96YvnRbO92Y=:Ol8FCRtNxbe5zW5Ex0Smjo
 9hocW3uykfNvq7ZGroLVluw7zsshIKi86W53SUrLaz4UoITYsqTPdOjzeNr/AMBQSvzJr6ZeQ
 MprHauvQRKpYVbUsLyOSpAJy8e+LTlIw01plIM72+xhkz092GUbzLJUNkiikXemjEzuOYlISP
 yNtISGcjotRLQ40CKvqVTFFPz3LdygYmNnFuvoRmNLzHNIap9zDSzek0RlqGpqhD5FfLRJIch
 w6QvZpU8XaiwM7cBrBmf3QhcArThg9hGGgolt8gTFgzwNax9bzwzNqn4+CdH2GOAWzbC5gZFx
 k7fij8xpshLHa4L7ZEG3OLoEgAXqOfYN666yiVEcqCEFe3M9NGBxRfzHgkbDYgaJCS0clgfvW
 Lp+z5m2auuPRGTS8JJCnIdydGoDTyRni1Yj+oi4CWqIh+fpWNU8skoLrGuZFdz/VY12p+21g7
 kw8f3f+79hr3++d/07t7KrQGosp8HDwkcirGFVX67N/cFm8sPN+Z85RJonXzdDrh2fk7OkQNk
 tbWNj/MNt/siBeZTEQ2OvvnmJu8a1iQEVSA4sd/LfqUgwuUTQ7QjzKavfLhVkp6h5z2SNJmO+
 Bjh0DNDmxnj8xuk5guhajOX1YucGjkcJB/9np2n6GZdOpiWklj6NYQBXkKU8udM/xg4IjAnF2
 /EqhMh3jnqp8rnpBvSVH9jzjY8jl9lKJ1vFCuopQcHadgVbhtd0CmtmivC6isXwDzqBnGIXm3
 a41BbozHkwExJycLAGOtMHxVxa1FFZ1kAWctBQbiM/qoxz5374fzN+9sXrMoAQjp148V1mpK 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290527>

On 01.04.16 12:44, Elia Pinto wrote:
> Implements the GIT_CURL_DEBUG environment variable to allow a greater
> degree of detail of GIT_CURL_VERBOSE, in particular the complete
> transport header and all the data payload exchanged.
> It might be useful if a particular situation could require a more
> thorough debugging analysis.
> 
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---
>  imap-send.c | 99 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 97 insertions(+), 2 deletions(-)
> 
> diff --git a/imap-send.c b/imap-send.c
> index 4d3b773..cf79e7f 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -1395,6 +1395,96 @@ static int append_msgs_to_imap(struct imap_server_conf *server,
>  }
>  
>  #ifdef USE_CURL_FOR_IMAP_SEND
> +
> +static
> +void curl_dump(const char *text,
> +	  FILE * stream, unsigned char *ptr, size_t size, char nohex)
Style: FILE *stream
> +{
> +	size_t i;
> +	size_t c;
c is typically a character.
'j' may be better, unless you find a longer,
and more descriptive name.

> +
> +	unsigned int width = 0x10;
> +
> +	if (nohex)
> +		/* without the hex output, we can fit more on screen */
> +		width = 0x40;
> +
> +	fprintf(stream, "%s, %10.10ld bytes (0x%8.8lx)\n",
> +		text, (long)size, (long)size);
> +
> +	for (i = 0; i < size; i += width) {
> +
> +		fprintf(stream, "%4.4lx: ", (long)i);
> +
> +		if (!nohex) {
> +			/* hex not disabled, show it */
> +			for (c = 0; c < width; c++)
> +				if (i + c < size)
> +					fprintf(stream, "%02x ", ptr[i + c]);
> +				else
> +					fputs("   ", stream);
> +		}
> +
> +		for (c = 0; (c < width) && (i + c < size); c++) {
> +			/* check for 0D0A; if found, skip past and start a new line of output */
Should we write '\r' and '\n' instead for hex codes ?
and CRLF instead of 0D0A ? (Yes the RFC use hexcodes, but we write readable C-code)
