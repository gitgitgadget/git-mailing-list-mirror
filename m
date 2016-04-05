From: Elia Pinto <gitter.spiros@gmail.com>
Subject: Re: [PATCH 1/2] imap-send.c: implements the GIT_CURL_DEBUG
 environment variable
Date: Tue, 5 Apr 2016 12:21:03 +0200
Message-ID: <CA+EOSBmL8oHo_wWUzyBq=4Z7fFoFj5Gnf7UveOyiNMS3yhH8Uw@mail.gmail.com>
References: <1459507482-36678-1-git-send-email-gitter.spiros@gmail.com>
	<CAPig+cRrmdiz4fHAX3xg6CinSOPBv207RZLaacRBkoDNHLaPwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Apr 05 12:21:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anO6m-0004uX-Cr
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 12:21:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755083AbcDEKVG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2016 06:21:06 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:35887 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751195AbcDEKVF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2016 06:21:05 -0400
Received: by mail-vk0-f67.google.com with SMTP id x190so1236195vka.3
        for <git@vger.kernel.org>; Tue, 05 Apr 2016 03:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=7bFzMZ00ZmDDVOxKpaisdPWONXzsJZQo0/gyHk0iYdk=;
        b=IBYJAJdiDcw4QohW9JsDNuH6beEY/vfJxgafpROinQls9CBDLx0eYgCRSkDou71pOx
         63bzdNx6PQmnP4g4Kdaca/lQ6T8ugbbPR2q4MP2kspYtGTSYP/ZrfqhYUX7xtPBbrcFl
         bYrrWZNbzXdF0q1xXYKBESmhMpLdQFILTUtFx10+IpMiq3SfWvMjta3gLguW5kzEcJN5
         jkUSuD0PFMPC3G6XyZTWx1NpR2q0S/MC3T/R6JuKZkUhpxTlOKvYiQvsn+F6XYQZ3XcP
         cE4zVSdm2RHx5rclZvipmKb1Fp2hFKUG6qdjurrdXn7Uh/iByuqPkKyog7Y+fdaUZVDu
         b92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=7bFzMZ00ZmDDVOxKpaisdPWONXzsJZQo0/gyHk0iYdk=;
        b=j6rOUBTgW8tWRIk/lOThIwi+k7XE2H9jXvcMT5QO8fRKG/yrrqbTMhRlmqdzsJ3gkx
         FpdMHSpxf1VTlWw4MrFUlG9a4w6WzxeW/NLjah31UInGNXC3D1FeM0d/GR9ivefs3g8V
         9hjl3laB+HQTH9nmctbuKFP1Mcugxhtn8g9w4vkpiU++PBZNC8/tTVDXI+E6KDKHQeKj
         OPWeCRTmg1sFTnZgvfilFblB19uloaxCono4raW/fP2vhu3GDRAgpwoEMkZTxSkCiUSZ
         RdRFnuElW+/oYtB2+JbJ5h7iBBLD0eIM+YfQukrZSswTBEkO1JR3noNeXv+KQdpA0jOn
         1Iqg==
X-Gm-Message-State: AD7BkJJ/4vnHke5GuggHaRwr/wELU5UrA1NucJtz3Y8FUVKraQo6CAcvBU4hMzYNhax8eU99h1/z7UNc6/+QzQ==
X-Received: by 10.31.8.210 with SMTP id 201mr11767072vki.90.1459851663264;
 Tue, 05 Apr 2016 03:21:03 -0700 (PDT)
Received: by 10.31.56.10 with HTTP; Tue, 5 Apr 2016 03:21:03 -0700 (PDT)
In-Reply-To: <CAPig+cRrmdiz4fHAX3xg6CinSOPBv207RZLaacRBkoDNHLaPwA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290771>

2016-04-01 22:25 GMT+02:00 Eric Sunshine <sunshine@sunshineco.com>:
> On Fri, Apr 1, 2016 at 6:44 AM, Elia Pinto <gitter.spiros@gmail.com> wrote:
>> Implements the GIT_CURL_DEBUG environment variable to allow a greater
>> degree of detail of GIT_CURL_VERBOSE, in particular the complete
>> transport header and all the data payload exchanged.
>> It might be useful if a particular situation could require a more
>> thorough debugging analysis.
>
> In addition to review comments by others, why are the new curl_dump()
> and curl_trace() functions duplicated in both patches rather than
> factored out to a shared implementation?
It's right. Do you think i can use some existing file or should I
create a new object file ?

Thank you very much
>
>> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
>> ---
>> diff --git a/imap-send.c b/imap-send.c
>> @@ -1395,6 +1395,96 @@ static int append_msgs_to_imap(struct imap_server_conf *server,
>>  }
>>
>>  #ifdef USE_CURL_FOR_IMAP_SEND
>> +
>> +static
>> +void curl_dump(const char *text,
>> +         FILE * stream, unsigned char *ptr, size_t size, char nohex)
>> +{
>> +       size_t i;
>> +       size_t c;
>> +
>> +       unsigned int width = 0x10;
>> +
>> +       if (nohex)
>> +               /* without the hex output, we can fit more on screen */
>> +               width = 0x40;
>> +
>> +       fprintf(stream, "%s, %10.10ld bytes (0x%8.8lx)\n",
>> +               text, (long)size, (long)size);
>> +
>> +       for (i = 0; i < size; i += width) {
>> +
>> +               fprintf(stream, "%4.4lx: ", (long)i);
>> +
>> +               if (!nohex) {
>> +                       /* hex not disabled, show it */
>> +                       for (c = 0; c < width; c++)
>> +                               if (i + c < size)
>> +                                       fprintf(stream, "%02x ", ptr[i + c]);
>> +                               else
>> +                                       fputs("   ", stream);
>> +               }
>> +
>> +               for (c = 0; (c < width) && (i + c < size); c++) {
>> +                       /* check for 0D0A; if found, skip past and start a new line of output */
>> +                       if (nohex && (i + c + 1 < size) && ptr[i + c] == 0x0D
>> +                           && ptr[i + c + 1] == 0x0A) {
>> +                               i += (c + 2 - width);
>> +                               break;
>> +                       }
>> +                       fprintf(stream, "%c",
>> +                               (ptr[i + c] >= 0x20)
>> +                               && (ptr[i + c] < 0x80) ? ptr[i + c] : '.');
>> +                       /* check again for 0D0A, to avoid an extra \n if it's at width */
>> +                       if (nohex && (i + c + 2 < size)
>> +                           && ptr[i + c + 1] == 0x0D
>> +                           && ptr[i + c + 2] == 0x0A) {
>> +                               i += (c + 3 - width);
>> +                               break;
>> +                       }
>> +               }
>> +               fputc('\n', stream);    /* newline */
>> +       }
>> +       fflush(stream);
>> +}
>> +
>> +static
>> +int curl_trace(CURL * handle, curl_infotype type,
>> +            char *data, size_t size, void *userp)
>> +{
>> +       const char *text;
>> +       (void)handle;           /* prevent compiler warning */
>> +
>> +       switch (type) {
>> +       case CURLINFO_TEXT:
>> +               fprintf(stderr, "== Info: %s", data);
>> +       default:                /* in case a new one is introduced to shock us */
>> +               return 0;
>> +
>> +       case CURLINFO_HEADER_OUT:
>> +               text = "=> Send header";
>> +               break;
>> +       case CURLINFO_DATA_OUT:
>> +               text = "=> Send data";
>> +               break;
>> +       case CURLINFO_SSL_DATA_OUT:
>> +               text = "=> Send SSL data";
>> +               break;
>> +       case CURLINFO_HEADER_IN:
>> +               text = "<= Recv header";
>> +               break;
>> +       case CURLINFO_DATA_IN:
>> +               text = "<= Recv data";
>> +               break;
>> +       case CURLINFO_SSL_DATA_IN:
>> +               text = "<= Recv SSL data";
>> +               break;
>> +       }
>> +
>> +       curl_dump(text, stderr, (unsigned char *)data, size, 1);
>> +       return 0;
>> +}
