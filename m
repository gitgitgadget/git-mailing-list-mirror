From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 52/94] builtin/apply: read_patch_file() return -1
 instead of die()ing
Date: Mon, 16 May 2016 19:19:25 +0200
Message-ID: <CAP8UFD0ewKeicNm=4frtdAz4YWR6-UuiBRXom0Ar-BKVpS36nA@mail.gmail.com>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
	<20160511131745.2914-53-chriscool@tuxfamily.org>
	<CAPig+cQrLZiwZm34+hFZXPmFGVtyPCvCEv4TwsTeL__cfzuORA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon May 16 19:20:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2MBO-0005RQ-KT
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 19:19:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753900AbcEPRT3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 13:19:29 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34233 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753661AbcEPRT0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 13:19:26 -0400
Received: by mail-wm0-f66.google.com with SMTP id n129so19543568wmn.1
        for <git@vger.kernel.org>; Mon, 16 May 2016 10:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=gzvSVppH1iAKIeoIR387x7uGjy1/0dZQssyeOUUEMys=;
        b=08eHGDiBNnT5nptBOmVTOm17wZaOhdL9qpSkLiTQPESqtyeDJiEE5mCho8b/JjMuNP
         ppUkex9IVRO5ICFleIRV4utQzfwdIPn66mWtCFueeJR7+Ip/x5p0Som6giEvGxXGLPCN
         o7k3Oxc5QoDd9T8BIX6l+apblghPALWgkb9PXCu6xu2Wds5f11KTHuiG1+FvRXLa0Dcx
         PPdYNspwTWhRmpmhEIOTLv+OJNr7FNOkx8f8p6zh4PLcCRJVIbABy/m+l7+nJ5EJK9dJ
         WUrWb6vwaXE/gn6hAs//q3ppIEVhWxtVd4/0wKBgtARVzkBjjEbNh5QNMy5psoP2W9JI
         cRDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=gzvSVppH1iAKIeoIR387x7uGjy1/0dZQssyeOUUEMys=;
        b=CarvT9o6qfEksdpBxq3t37IcpfIRf3RUljxwDoDHyCQ8hkkJl5TDLXyYeg0C8dBADq
         ECyL1D7xQA3iA1udJr7o109L2ODZ1sNH33UB+V93+0dPDqDaq5qk2bEbpCoVC4cZsyUp
         aI/vfaSfDAI/ZNBs7BZDARnedZ8bhF3nh/mcSzJJV/65wwA7AxUahGldXsU0S9OtLJEj
         7ZdN902e9x+yXMVPs9ev83YVih4jwh2N2TMdHERzVCETmV2FRzg4cnuYfcrtSns9xLF7
         14XSLMbDTU/06G8GiLcDoZwAdQcXRc5ubkB4DMfJleZ6mKzkO+c6emfe41bhLxwef7y6
         HyxA==
X-Gm-Message-State: AOPr4FX/jJqS19DU+ixU/1DujQgtD65+eVIRCQg4/DpLRN0h2SpBF/OhisVWxAbafG3jQMLf9dL8u1kOx+rViQ==
X-Received: by 10.195.17.166 with SMTP id gf6mr30486092wjd.124.1463419165559;
 Mon, 16 May 2016 10:19:25 -0700 (PDT)
Received: by 10.194.246.4 with HTTP; Mon, 16 May 2016 10:19:25 -0700 (PDT)
In-Reply-To: <CAPig+cQrLZiwZm34+hFZXPmFGVtyPCvCEv4TwsTeL__cfzuORA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294757>

On Mon, May 16, 2016 at 3:56 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, May 11, 2016 at 9:17 AM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> To libify `git apply` functionality we have to signal errors to the
>> caller instead of die()ing. Let's do that by using error() instead
>> of die()ing in read_patch_file().
>>
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>> diff --git a/builtin/apply.c b/builtin/apply.c
>> @@ -445,10 +445,10 @@ static void say_patch_name(FILE *output, const char *fmt, struct patch *patch)
>> -static void read_patch_file(struct strbuf *sb, int fd)
>> +static int read_patch_file(struct strbuf *sb, int fd)
>>  {
>>         if (strbuf_read(sb, fd, 0) < 0)
>> -               die_errno("git apply: failed to read");
>> +               return error("git apply: failed to read: %s", strerror(errno));
>
> When Duy's nd/error-errno series, which is in 'next', gets promoted to
> 'master', then this could become:
>
>     return error_errno(...);

Yeah, sure.
