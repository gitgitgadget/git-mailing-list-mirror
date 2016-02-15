From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 21/25] fetch: define shallow boundary with --shallow-exclude
Date: Mon, 15 Feb 2016 10:53:27 +0700
Message-ID: <CACsJy8B=p0frmU8ahc9bnk-uoDPNUT_6UB0MVRPiLc9DqNz3vQ@mail.gmail.com>
References: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
 <1454576641-29615-22-git-send-email-pclouds@gmail.com> <CAPig+cQA6yV369b7hM_Q8aPuAwF8tR1xT=jr1r2PH1KsCtHWtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 04:54:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVAEe-00014O-DB
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 04:54:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751706AbcBODx7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Feb 2016 22:53:59 -0500
Received: from mail-lb0-f174.google.com ([209.85.217.174]:34705 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751608AbcBODx6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Feb 2016 22:53:58 -0500
Received: by mail-lb0-f174.google.com with SMTP id ap4so13644252lbd.1
        for <git@vger.kernel.org>; Sun, 14 Feb 2016 19:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=V9jReR9AueHvknkpGmWCyXW+nuIJOUAL2awSRaZmOMw=;
        b=bCh5/2ANgFDuaP06HrgaODQmetFQvooZriUf7OxZ/hyRW8k3mtdS6Kv0zAeorV5cVB
         OIyWDaaLaW097Vcw9oJsDkkzO2133PyGmvUTF0NLs7Xt+6fXne3YTBwhHHSKsTiiqsWF
         9Y5wKIG8Hgpt8YyUwma5OCtlhUC3aocomN8OLaTMyxLv/2tqGX/oLgZzqZQb/42asRsK
         u4YuxtIMWTxGJ1+4WGMluUaQrla16NVY6LqONExo2+zsr2PMdU9Etddg7PbCCYKHhQSC
         LXpNndKHqePWvkqTgdd6yzNPKfmuywVs75k2ENVMVLhOzU629py/gY41o3xQrttLwVI0
         M43w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=V9jReR9AueHvknkpGmWCyXW+nuIJOUAL2awSRaZmOMw=;
        b=AhSer18I4QlVfOuzqksGzyWHtso7XkVWpTVK17IbHuJutvi2+a+rF6xZR6XjCH15Ui
         z8rF1pvWVM6Q1hIdd9UzgS5hYq8cVPQnIfw7hGUPJiAMIWouKAWu5M+9WBt4O9towrA6
         hsdbuzvs1WrpsakSTqfOHxf+VWKcCGHziSjts/2Uuat9/jFcXr/lSG5EglxU4Cwngr/y
         kaUfCF8xcy3gdhVhy/DyNnCw/x6NsG6C1hER3g92HwXfxzAZv61Jjm8Os3I5UlojynId
         ShDWHk/jitlAvCVbbwytLEviz5orfp0ntEJphkSsqmD/NWLZOU0oICcHmqbrv2uG5py8
         ldgg==
X-Gm-Message-State: AG10YOS+eSUsmOHttA1wVLj6rL+CVuASQSFmXV/3KmzWEnOvazwmVI/+S8eSYnoWo+uQ8ZeMG7ZnosYt5CS7pA==
X-Received: by 10.112.12.2 with SMTP id u2mr5700330lbb.145.1455508437444; Sun,
 14 Feb 2016 19:53:57 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Sun, 14 Feb 2016 19:53:27 -0800 (PST)
In-Reply-To: <CAPig+cQA6yV369b7hM_Q8aPuAwF8tR1xT=jr1r2PH1KsCtHWtQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286169>

On Fri, Feb 5, 2016 at 12:26 PM, Eric Sunshine <sunshine@sunshineco.com=
> wrote:
> On Thu, Feb 4, 2016 at 4:03 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc=
 Duy <pclouds@gmail.com> wrote:
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>> diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
>> @@ -109,6 +109,16 @@ int cmd_fetch_pack(int argc, const char **argv,=
 const char *prefix)
>> +               if (skip_prefix(arg, "--shallow-exclude=3D", &value)=
) {
>> +                       static struct string_list *deepen_not;
>> +                       if (!deepen_not) {
>> +                               deepen_not =3D xmalloc(sizeof(*deepe=
n_not));
>> +                               string_list_init(deepen_not, 1);
>> +                               args.deepen_not =3D deepen_not;
>> +                       }
>> +                       string_list_append(deepen_not, value);
>> +                       continue;
>> +               }
>
> Hmm, can't this be simplified to:
>
>     if (skip_prefix(arg, "--shallow-exclude=3D", &value)) {
>         if (!args.deepen_not) {
>             args.deepen_not =3D xmalloc(sizeof(*args.deepen_not));
>             string_list_init(args.deepen_not, 1);
>         }
>         string_list_append(args.deepen_not, value);
>         continue;
>     }

args.deepen_not is const, so no, the compiler will complain at
string_list_init and string_list_append. Dropping "const" is one
option, if you prefer.

> Or, perhaps even better, declare it as plain 'struct string_list
> deepen_not' in struct fetch_pack_args, rather than as a pointer, and
> then in cmd_fetch_pack():
>
>     memset(&args, 0, sizeof(args));
>     args.uploadpack =3D "git-upload-pack";
>     string_list_init(&args.deepen_not, 1);

There's another place fetch_pack_args variable is declared, in
fetch_refs_via_pack(), and we would need to string_list_copy() from
transport->data->options.deepen_not and then free it afterward. So I
think it's not really worth it.

>     if (skip_prefix(arg, "--shallow-exclude=3D", &value)) {
>         string_list_append(args.deepen_not, value);
>         continue;
>     }
--=20
Duy
