From: John Szakmeister <john@szakmeister.net>
Subject: Re: [PATCH 4/4] fast-export: trivial cleanup
Date: Thu, 9 May 2013 04:52:15 -0400
Message-ID: <CAEBDL5VotNSZC_xHc3r49bBFtNwU+drWa_Pj=skC3xzk-CGpKA@mail.gmail.com>
References: <1368062218-22440-1-git-send-email-felipe.contreras@gmail.com>
	<1368062218-22440-5-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 09 10:52:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaMaQ-0005dt-VV
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 10:52:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752904Ab3EIIwT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 04:52:19 -0400
Received: from mail-we0-f171.google.com ([74.125.82.171]:63794 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752807Ab3EIIwQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 04:52:16 -0400
Received: by mail-we0-f171.google.com with SMTP id u55so2599054wes.2
        for <git@vger.kernel.org>; Thu, 09 May 2013 01:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=1RuKHYWfdFK6mU9hWHV/m9RsFeGAyR+yCvAWxciwo/c=;
        b=hH5k+fCYW8wluLSQHgwYS/GRCmGZZKL791ZXkPDv2s9RfTszgJKiF8QVGpB5L4rhUf
         6LpvLU6Ai790NGJybar+J6CgqpdH78ugsLSh9UnGaJhroIRJHB3JZEwAlNnWZYlefR+Y
         e5k/S/KyFrs5YOJLSWO3SqJtD0Gp0mOFzFoA48zdKAjQKo35qkeOJUfLL88uPCI6/jNz
         jb6/PVi1Znqwy6qdkol+PVluSqy+95uvK4ONxbP9Pux9W9x01kcprryVDPrwTw87Qkoe
         3MRzI5A/ccdcbfGRFqzR1IL+5oIBrJUSfOrr4X82q+bsvgg82RM73hwHitnMkPU+dtOv
         +KUQ==
X-Received: by 10.194.76.199 with SMTP id m7mr16374123wjw.43.1368089535206;
 Thu, 09 May 2013 01:52:15 -0700 (PDT)
Received: by 10.180.78.69 with HTTP; Thu, 9 May 2013 01:52:15 -0700 (PDT)
In-Reply-To: <1368062218-22440-5-git-send-email-felipe.contreras@gmail.com>
X-Google-Sender-Auth: fuE88BoIFdwXv15dtv6BOFBZOQU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223717>

On Wed, May 8, 2013 at 9:16 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Cast the object to a commit, only to get the object back?
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  builtin/fast-export.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> index 8091354..d24b4d9 100644
> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> @@ -550,7 +550,6 @@ static void get_tags_and_duplicates(struct rev_cmdline_info *info,
>
>  static void handle_tags_and_duplicates(struct string_list *extra_refs)
>  {
> -       struct commit *commit;
>         int i;
>
>         for (i = extra_refs->nr - 1; i >= 0; i--) {
> @@ -562,9 +561,7 @@ static void handle_tags_and_duplicates(struct string_list *extra_refs)
>                         break;
>                 case OBJ_COMMIT:
>                         /* create refs pointing to already seen commits */
> -                       commit = (struct commit *)object;
> -                       printf("reset %s\nfrom :%d\n\n", name,
> -                              get_object_mark(&commit->object));
> +                       printf("reset %s\nfrom :%d\n\n", name, get_object_mark(object));

FWIW, this line is now too long (exceeds 80 columns).  Good catch on
the casting though.

-John

PS  Sorry for the duplicate Felipe... I still need to get used to
hitting "Reply All". :-)
