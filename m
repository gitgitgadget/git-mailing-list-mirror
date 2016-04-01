From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/2] imap-send.c: implements the GIT_CURL_DEBUG
 environment variable
Date: Fri, 1 Apr 2016 16:25:34 -0400
Message-ID: <CAPig+cRrmdiz4fHAX3xg6CinSOPBv207RZLaacRBkoDNHLaPwA@mail.gmail.com>
References: <1459507482-36678-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 22:25:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1am5dT-00040O-I0
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 22:25:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752752AbcDAUZf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 16:25:35 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:35334 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751714AbcDAUZf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 16:25:35 -0400
Received: by mail-yw0-f196.google.com with SMTP id u8so22035527ywa.2
        for <git@vger.kernel.org>; Fri, 01 Apr 2016 13:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=VVgUePVA/81AEljBhxdvdG7CYqctSNgsE6mLpxjlTvQ=;
        b=YBmayxjcofwGs6TP3/lqlPvfFxuirl7xdPwv2Q68RGT2ytletpcardVX1i+WSi07Gw
         +zBG8RSJZVOdFuwHrcz9LGos93CEmS886aeizfVcb38ESS0ZUBBXy317XI22C8SH2AQa
         d6Vxs55JN1PcTn2hPuMFy44BXAVm6SUFFoIK0sUErBNetpLfbAtCrSgHJauTjuQmfB8f
         7Y//bMVcoBD16DQP6KyTDsnx9TjytksIsqGzpjWa/QBDigdRPez8DfhoxjaKe1NLpRCx
         FiM+bYW9nb2i5aC52ghglxiNdbMlvWS8E73QaK79yKYr2UtQ8ulmQURLj8UcRaYG9W1z
         13mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=VVgUePVA/81AEljBhxdvdG7CYqctSNgsE6mLpxjlTvQ=;
        b=WHbpexls+zRDOvh9BmSkioAX9bHwBkczoEC3WT0lLXXXiZsbgEdQI0xuGeVgRxn8UA
         kfUBJcUWnrFeRtqoQlM64bEnSmJFsOuc167+1jxvMZGWVdrYTh1PhYVbcvIqeWgdwPIC
         OBWU/PcvF0tsbT2vGQPBbDgFtNda0zdrzbwulVI8L/ab6+2OLPvC+NuYW4GlCfbhlEwc
         sTvQOjKDQt86t370clwg8p88ooZFwn+/5Io7575CXy+VdYj6ssDSVsGUqQ10tsi9BtDW
         KQ/qWIy/b1JxE3WozJyooNEr4CuENewY1ev/urUm2qWDWdKQ+pj5m4OgtlnGwPikXL8p
         V16w==
X-Gm-Message-State: AD7BkJIsZ6vfNZ+SvJRKY1nhEK5hkphDozEXJMgd8kKi3sONmqwl+CypQ/vbKvjaz1vpmfpZNc5M2qOwl7/0RA==
X-Received: by 10.31.146.5 with SMTP id u5mr50981vkd.19.1459542334382; Fri, 01
 Apr 2016 13:25:34 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Fri, 1 Apr 2016 13:25:34 -0700 (PDT)
In-Reply-To: <1459507482-36678-1-git-send-email-gitter.spiros@gmail.com>
X-Google-Sender-Auth: pe7HrgBQCxfJ4tUfL2UhWcxAbpw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290580>

On Fri, Apr 1, 2016 at 6:44 AM, Elia Pinto <gitter.spiros@gmail.com> wrote:
> Implements the GIT_CURL_DEBUG environment variable to allow a greater
> degree of detail of GIT_CURL_VERBOSE, in particular the complete
> transport header and all the data payload exchanged.
> It might be useful if a particular situation could require a more
> thorough debugging analysis.

In addition to review comments by others, why are the new curl_dump()
and curl_trace() functions duplicated in both patches rather than
factored out to a shared implementation?

> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---
> diff --git a/imap-send.c b/imap-send.c
> @@ -1395,6 +1395,96 @@ static int append_msgs_to_imap(struct imap_server_conf *server,
>  }
>
>  #ifdef USE_CURL_FOR_IMAP_SEND
> +
> +static
> +void curl_dump(const char *text,
> +         FILE * stream, unsigned char *ptr, size_t size, char nohex)
> +{
> +       size_t i;
> +       size_t c;
> +
> +       unsigned int width = 0x10;
> +
> +       if (nohex)
> +               /* without the hex output, we can fit more on screen */
> +               width = 0x40;
> +
> +       fprintf(stream, "%s, %10.10ld bytes (0x%8.8lx)\n",
> +               text, (long)size, (long)size);
> +
> +       for (i = 0; i < size; i += width) {
> +
> +               fprintf(stream, "%4.4lx: ", (long)i);
> +
> +               if (!nohex) {
> +                       /* hex not disabled, show it */
> +                       for (c = 0; c < width; c++)
> +                               if (i + c < size)
> +                                       fprintf(stream, "%02x ", ptr[i + c]);
> +                               else
> +                                       fputs("   ", stream);
> +               }
> +
> +               for (c = 0; (c < width) && (i + c < size); c++) {
> +                       /* check for 0D0A; if found, skip past and start a new line of output */
> +                       if (nohex && (i + c + 1 < size) && ptr[i + c] == 0x0D
> +                           && ptr[i + c + 1] == 0x0A) {
> +                               i += (c + 2 - width);
> +                               break;
> +                       }
> +                       fprintf(stream, "%c",
> +                               (ptr[i + c] >= 0x20)
> +                               && (ptr[i + c] < 0x80) ? ptr[i + c] : '.');
> +                       /* check again for 0D0A, to avoid an extra \n if it's at width */
> +                       if (nohex && (i + c + 2 < size)
> +                           && ptr[i + c + 1] == 0x0D
> +                           && ptr[i + c + 2] == 0x0A) {
> +                               i += (c + 3 - width);
> +                               break;
> +                       }
> +               }
> +               fputc('\n', stream);    /* newline */
> +       }
> +       fflush(stream);
> +}
> +
> +static
> +int curl_trace(CURL * handle, curl_infotype type,
> +            char *data, size_t size, void *userp)
> +{
> +       const char *text;
> +       (void)handle;           /* prevent compiler warning */
> +
> +       switch (type) {
> +       case CURLINFO_TEXT:
> +               fprintf(stderr, "== Info: %s", data);
> +       default:                /* in case a new one is introduced to shock us */
> +               return 0;
> +
> +       case CURLINFO_HEADER_OUT:
> +               text = "=> Send header";
> +               break;
> +       case CURLINFO_DATA_OUT:
> +               text = "=> Send data";
> +               break;
> +       case CURLINFO_SSL_DATA_OUT:
> +               text = "=> Send SSL data";
> +               break;
> +       case CURLINFO_HEADER_IN:
> +               text = "<= Recv header";
> +               break;
> +       case CURLINFO_DATA_IN:
> +               text = "<= Recv data";
> +               break;
> +       case CURLINFO_SSL_DATA_IN:
> +               text = "<= Recv SSL data";
> +               break;
> +       }
> +
> +       curl_dump(text, stderr, (unsigned char *)data, size, 1);
> +       return 0;
> +}
