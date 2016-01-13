From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 2/2] interpret-trailers: add option for in-place editing
Date: Wed, 13 Jan 2016 13:15:54 -0500
Message-ID: <CAPig+cSX04OSLQVk-LHm2UQOAqThQUJuFhuhUfoNmUvHmZpPsA@mail.gmail.com>
References: <1452688989-13746-1-git-send-email-tklauser@distanz.ch>
	<1452688989-13746-3-git-send-email-tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Tobias Klauser <tklauser@distanz.ch>
X-From: git-owner@vger.kernel.org Wed Jan 13 19:16:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJPxh-0003Jo-1s
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 19:16:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754874AbcAMSP5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 13:15:57 -0500
Received: from mail-vk0-f66.google.com ([209.85.213.66]:34322 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752568AbcAMSPz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 13:15:55 -0500
Received: by mail-vk0-f66.google.com with SMTP id a123so8342973vkh.1
        for <git@vger.kernel.org>; Wed, 13 Jan 2016 10:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=N4tT8aejXbqzdWQ2HG0GkRw1jNGGg2yvngYW7bdtSto=;
        b=i9gMs3abfFNtbhiJJt77RTkkeaFlvSswLChUjYwrQG2VTS6NeBwDmU4oQbH3i2uFXH
         fNjBnA6O6KAAM+39fIZ5+tSt96i2lfmrWOUGC15RQca1CTMeNkLsRxSgHHpuMGfrIExV
         b+UZrsy2CZ02OOGQ4t9RhHkc10CmiMbJaq8Kh1m2Icp8jXqgZ76utnYwAvjmGGVIsMZJ
         43iQPCehvd8W6zQHu44syT2NeFJUzHghlBNR+iWIP79u/XyvW46pafRPWk4fVnexct3+
         B6GeNJxbdWYLQNvN7kmhn/NqhEXC6RYzULnG1qLc+fTCFtPNirl/w4MMgWpL5Er5mntS
         hGww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=N4tT8aejXbqzdWQ2HG0GkRw1jNGGg2yvngYW7bdtSto=;
        b=PkaNhC7G4etntVNWWzDGZGM1838tohemF78/dTku2CWHi6zfh0QIXdK4pEo3HgTpL1
         lPXbpGyGdq7madLL/Mb1NIWCtbIGTu1SEZKHRRxmyVDwAmLcAYu3R8MBU1LBIdQQsmeo
         XtpReldz+HA/tp0p1J8Dz9SZU6GOiHzd6P+CccGFFpaBxeXIxAl6Mgj38pUiv9FJnAT7
         FtnGdXaSRw9x+b4nTTX/cWiRKy35jOMLE/JCefeYcy6yoW3uZtw4G1oOvEEnc88LDkGd
         eWyxCMaO8ODIdNO9h27IFH/nw7RUIYOBgJ0mTWdT5rtTJzqlbxipbAUMIFZ8mjkImFe7
         Kjnw==
X-Gm-Message-State: ALoCoQkOhQtyyfAKHUpihjJqbNIUtO7yvuxSeCV9eYvyRlv0sAEQEA78P7valn/cYJod0Vd0XpKf5IOYibd9IwshENFZAyjsPw==
X-Received: by 10.31.182.143 with SMTP id g137mr64204329vkf.45.1452708954959;
 Wed, 13 Jan 2016 10:15:54 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Wed, 13 Jan 2016 10:15:54 -0800 (PST)
In-Reply-To: <1452688989-13746-3-git-send-email-tklauser@distanz.ch>
X-Google-Sender-Auth: -o3_JKtsn00mmet9O828SOWss6w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283959>

On Wed, Jan 13, 2016 at 7:43 AM, Tobias Klauser <tklauser@distanz.ch> wrote:
> Add a command line option --in-place to support in-place editing akin to
> sed -i.  This allows to write commands like the following:
>
>   git interpret-trailers --trailer "X: Y" a.txt > b.txt && mv b.txt a.txt
>
> in a more concise way:
>
>   git interpret-trailers --trailer "X: Y" --in-place a.txt
>
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---
> diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
> @@ -326,6 +326,38 @@ test_expect_success 'with complex patch, args and --trim-empty' '
> +test_expect_success 'in-place editing on stdin' '

Maybe say:

    "in-place editing on stdin disallowed"

or something?

> +       test_must_fail git interpret-trailers --trailer "Reviewed-by: Alice" --in-place < basic_message
> +'
> +
> +test_expect_success 'in-place editing on non-existing file' '
> +       test_must_fail git interpret-trailers --trailer "Reviewed-by: Alice" --in-place nonexisting &&
> +       test_path_is_missing nonexisting
> +'

An significant shortcoming of the first version of this patch series
was that it did not treat the input file as precious, and would
happily delete it if trailer processing failed for any reason. This is
behavior we'd like to protect against. Toward that end, have you
considered adding a test to verify that the input file is indeed
considered precious, and not deleted upon failure? One way to do so
would be to write a test which triggers one of the failure conditions
of the interpret-trailers framework. Looking at the source code, one
possible way would be to make trailer.c:read_input_file() fail, for
instance, by making the file unreadable (with 'chmod -r', though you'd
have to protect the test with the POSIXPERM prerequisite).

More below.

> diff --git a/trailer.c b/trailer.c
> @@ -858,6 +861,31 @@ void process_trailers(const char *file, int trim_empty, struct string_list *trai
>
>         lines = read_input_file(file);
>
> +       if (in_place) {
> +               struct stat st;
> +               struct strbuf template = STRBUF_INIT;
> +               const char *tail;
> +
> +               if (stat(file, &st))
> +                       die_errno(_("could not stat %s"), file);
> +               if (!S_ISREG(st.st_mode))
> +                       die(_("file %s is not a regular file"), file);
> +               if (!(st.st_mode & S_IWUSR))
> +                       die(_("file %s is not writable by user"), file);
> +
> +               /* Create temporary file in the same directory as the original */
> +               tail = strrchr(file, '/');
> +               if (tail != NULL)
> +                       strbuf_add(&template, file, tail - file + 1);
> +               strbuf_addstr(&template, "git-interpret-trailers-XXXXXX");
> +
> +               xmks_tempfile_m(&trailers_tempfile, template.buf, st.st_mode);
> +               strbuf_release(&template);
> +               outfile = fdopen_tempfile(&trailers_tempfile, "w");
> +               if (!outfile)
> +                       die_errno(_("could not open temporary file"));
> +       }

Hmm, the current logic of process_trailers() is pretty easily
understood at a glance, but this new (relatively huge) chunk of code
obscures the overall operation. Have you considered factoring the new
code out into its own function in order to keep the overall flow of
process_trailers() clean? (Genuine question; I don't necessarily feel
so strongly about it to demand such a change.)

>         /* Print the lines before the trailers */
>         trailer_end = process_input_file(outfile, lines, &in_tok_first, &in_tok_last);
>
> @@ -872,5 +900,10 @@ void process_trailers(const char *file, int trim_empty, struct string_list *trai
>         /* Print the lines after the trailers as is */
>         print_lines(outfile, lines, trailer_end, INT_MAX);
>
> +       if (in_place) {
> +               if (rename_tempfile(&trailers_tempfile, file))
> +                       die_errno(_("could not rename temporary file to %s"), file);
> +       }

You could drop the unnecessary braces.

>         strbuf_list_free(lines);
>  }
