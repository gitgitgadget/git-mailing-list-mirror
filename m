From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 01/12] path.c: add git_common_path() and strbuf_git_common_path()
Date: Thu, 21 Apr 2016 07:28:06 +0700
Message-ID: <CACsJy8BYmXi_a-sJ2Z+J-rd+DTyQYnznc87_2EHfv_Ym-Fz0pg@mail.gmail.com>
References: <1460897965-486-1-git-send-email-pclouds@gmail.com>
 <1461158693-21289-1-git-send-email-pclouds@gmail.com> <1461158693-21289-2-git-send-email-pclouds@gmail.com>
 <CAPig+cSRQBJM9xFnDszC84Z3JaF83sOg7=z-w6nRQdcu6nA3Bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Reto_Habl=C3=BCtzel?= <rethab.ch@gmail.com>,
	Mike Rappazzo <rappazzo@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 02:28:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1at2U6-0005WZ-S0
	for gcvg-git-2@plane.gmane.org; Thu, 21 Apr 2016 02:28:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751563AbcDUA2i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Apr 2016 20:28:38 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:32983 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382AbcDUA2h convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2016 20:28:37 -0400
Received: by mail-lb0-f174.google.com with SMTP id u8so18348061lbk.0
        for <git@vger.kernel.org>; Wed, 20 Apr 2016 17:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=u0xYuMNP0ZZyWHNCu3ZaCm6p+IQxDFBYOSnWoWOt+XU=;
        b=Xi3fHWAMkzVOyii4f+F9xgBCMCc6NSpziyrC9jttKmC6I332pxEZWs2aV1xjJPTaaL
         lo6/o5ZjKg4+Z8jDaVWxr9phAJmS0sHqlkxlXqGlaGvxeH7cqj1SECoesC68lg4Dq22v
         z5SW91Bcc0bIRY3x44vlONm5gGG8dTR9hTiBnDABHZsaLD/c8tCEmv7xdt404f+kIpXF
         H5m/K9npdomTISKK+GQxeLvzk/QXuPviNNXVyOdAjonF6Has49hIYetOsR0o7D/Spj20
         Fto34Tm/CvwEUmp2sC7yQtAvjuvvKQ+Me9om3xhy1++zBieKAdoYDo15FATDJyViI8K8
         hIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=u0xYuMNP0ZZyWHNCu3ZaCm6p+IQxDFBYOSnWoWOt+XU=;
        b=e0dy2C6fLhanUt3C79ZKV5z+r3TJ9eU62LdhejY2h2p9EvvvAakoDJor+nfd4SA3OB
         0gN2XWNYdy5ib7jJGJYdzxkOURa9y2ONc4ejqRoy6iGA3p6moItp+1c93nKE5dGIBJZi
         8+MzF5ztnegZuwq7Gnsm8f2H/ecemLlxH4ktO42XxjHTrTpaycCWBdch8EhksFKzghFC
         RgZD5C8goEk6OqL+iXTacAnaNg8kL9nAKJMvNX3M+H/i569XhJz0YFZnLn1WSm8neMIN
         ivZmZmwUrg0mfCstsxnypUUaE+QdHUM9/CmYdAkotC12Zw1Avp+lbzbK3kh9ik3pqcDa
         00nw==
X-Gm-Message-State: AOPr4FUE43bYd6kpWGguzpPFbvm8lAO0XGvhzFDOFdY/aP4bc6r05iFrWeQe8oq+TPa3bMnjHJe3y9S7cDLUSQ==
X-Received: by 10.112.54.132 with SMTP id j4mr4877634lbp.3.1461198516044; Wed,
 20 Apr 2016 17:28:36 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Wed, 20 Apr 2016 17:28:06 -0700 (PDT)
In-Reply-To: <CAPig+cSRQBJM9xFnDszC84Z3JaF83sOg7=z-w6nRQdcu6nA3Bw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292090>

On Thu, Apr 21, 2016 at 1:11 AM, Eric Sunshine <sunshine@sunshineco.com=
> wrote:
> On Wed, Apr 20, 2016 at 9:24 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy <pclouds@gmail.com> wrote:
>> diff --git a/path.c b/path.c
>> @@ -503,6 +503,35 @@ void strbuf_git_path_submodule(struct strbuf *b=
uf, const char *path,
>> +const char *git_common_path(const char *fmt, ...)
>> +{
>> +       struct strbuf *pathname =3D get_pathname();
>> +       va_list args;
>> +       va_start(args, fmt);
>> +       do_git_common_path(pathname, fmt, args);
>> +       va_end(args);
>> +       return pathname->buf;
>
> Is the caller expected to free this value? If not, then shouldn't
> 'pathname' be static? If so, then perhaps strbuf_detach() would be
> clearer (and return 'char *' rather than 'const char *').

get_pathname() actually holds a ring of static buffer. So no, we don't
need static pathname, it can be a new buffer next time, mostly to to
make printf("%s %s", git_common_path(..), git_common_path(..)) work.
And no the caller is not supposed to free it, a little bit more
convenient.
--=20
Duy
