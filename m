From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 01/12] path.c: add git_common_path() and strbuf_git_common_path()
Date: Wed, 20 Apr 2016 14:11:15 -0400
Message-ID: <CAPig+cSRQBJM9xFnDszC84Z3JaF83sOg7=z-w6nRQdcu6nA3Bw@mail.gmail.com>
References: <1460897965-486-1-git-send-email-pclouds@gmail.com>
	<1461158693-21289-1-git-send-email-pclouds@gmail.com>
	<1461158693-21289-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	rethab.ch@gmail.com, Mike Rappazzo <rappazzo@gmail.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 20:11:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aswau-00030i-T2
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 20:11:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751990AbcDTSLQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Apr 2016 14:11:16 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:37408 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751979AbcDTSLQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2016 14:11:16 -0400
Received: by mail-ig0-f170.google.com with SMTP id g8so57320415igr.0
        for <git@vger.kernel.org>; Wed, 20 Apr 2016 11:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=s9gHhIMB6T3RuLxncUf+OnP07IsbI1g8V6hCpAF0BZQ=;
        b=OQ/36Gj/kyrciVq2Se+x6/RHtUcxrNEQ6wf7Qk2HoK9BnCQUz+2m3BUfVEnCVPodU0
         1syptAUZlxmco1KhVlmvgy79duD4qLL6X0vRCaJrfpyZ39UQR7ciRj4TceZ2Zgn+r9SE
         bIxyB/z36hx1YSe3+uy8e/jCgENh5CcE/ev3qpDyXjxpEXVrK/KFQx3N2uFM9yVXUkCg
         wTWrtWFqnPdWPcM2quyGFWABvsz2Z2xtp9ONz94ONg/D6RXnfpTRhlio6OPAlB/ocDkb
         MwTNvNdomabuKXSgjUSYDP6yPpO9XXY64WU144c0b4JfdIN9uEVJUzy5n9JZ9EZUkSzK
         2mdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=s9gHhIMB6T3RuLxncUf+OnP07IsbI1g8V6hCpAF0BZQ=;
        b=QV9l7EaR2Up032+bqKq+G3usovRtJz00Poi3GzPJT5Fkrq8Tu/Y9G1HYYFwsZUuK0B
         2bF70EgvcKBt5dY9kc2OJOKSPmz1WIUkUmm7kZilR2DNeaPh4DGCjMJ4X+yLRkY0pZRK
         M0vR5k+7Nfqt7kw7XbGUaOgOgfPM3HTcLMrbxKP7SxQvKIuEEgb2LmTPqnkzewyZYF7I
         12n8idqZKvTG8qKlXbaOCk/5Qv8dpXoYCglC88wWJut7LtzBXWp+VPsSPneK9E3+8/AB
         O2YuNS/k5uipbdCAXPH8TbCudCZkmbK/x0mbA83jNKYlc6Th7y4ezsmoW3AYfccKA4I6
         pTmw==
X-Gm-Message-State: AOPr4FWW9uD3zNPQd9ay51/ELa3kHMs3K7BwYqyhcENw9zGPMekzHRdUgX31c841S3VkECD5Z5TfOl1CuCMyVQ==
X-Received: by 10.50.77.107 with SMTP id r11mr5376686igw.91.1461175875207;
 Wed, 20 Apr 2016 11:11:15 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Wed, 20 Apr 2016 11:11:15 -0700 (PDT)
In-Reply-To: <1461158693-21289-2-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: FoOpUd_VHMW9xnXDbrdLwQaL0XQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292050>

On Wed, Apr 20, 2016 at 9:24 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> diff --git a/path.c b/path.c
> @@ -503,6 +503,35 @@ void strbuf_git_path_submodule(struct strbuf *bu=
f, const char *path,
> +const char *git_common_path(const char *fmt, ...)
> +{
> +       struct strbuf *pathname =3D get_pathname();
> +       va_list args;
> +       va_start(args, fmt);
> +       do_git_common_path(pathname, fmt, args);
> +       va_end(args);
> +       return pathname->buf;

Is the caller expected to free this value? If not, then shouldn't
'pathname' be static? If so, then perhaps strbuf_detach() would be
clearer (and return 'char *' rather than 'const char *').

> +}
