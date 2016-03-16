From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH/RFC/GSoC 05/17] rebase-options: implement
 rebase_options_load() and rebase_options_save()
Date: Wed, 16 Mar 2016 20:04:07 +0800
Message-ID: <CACRoPnS7WWWVay9hAjXYgyeB=1A1gfARerKJe25APa-6u5cGaA@mail.gmail.com>
References: <1457779597-6918-1-git-send-email-pyokagan@gmail.com>
	<1457779597-6918-6-git-send-email-pyokagan@gmail.com>
	<CAGZ79kYeYzi=J=dY27FqXp72BRe-Vmm4MR5Q6dFTMUP9CxYZcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Duy Nguyen <pclouds@gmail.com>,
	Sam Halliday <sam.halliday@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 13:04:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agABT-0001wd-7M
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 13:04:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966292AbcCPMEM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 08:04:12 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:33330 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965880AbcCPMEJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 08:04:09 -0400
Received: by mail-lb0-f174.google.com with SMTP id oe12so46519593lbc.0
        for <git@vger.kernel.org>; Wed, 16 Mar 2016 05:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=/dJRfHQQv17qvch/geNaWxXrNWhf1Bv8zhSa55DD+9M=;
        b=rf6wYgNvPeMCfFuWQrH57DmxD48K5avhdrF5UafAPuCmsXhJF5nPloBisyasMYFQ1n
         FwcfRaF9wVFvKqrF+i2J139meynxZd7IpCD45E8Na73HoO193DIy/B/YmfmeWCYChwVD
         wXtbGhjNY2azpRCRHvRSFlpb8StFK0Eah0q5KWf72mxgI2DBOyip/ASReYflpVu9DX0z
         HcILJvu8aHOWwJlRhEqq7mbqFg/dx0qwt/8D02U+EFDiNaWxswEqH0GPlRu3gWOkk3NN
         rax8DgvX613qcKH2U/MWUsIyC784fFC6xRGFp3RIPhSB1FVl9XHERQilCdBGTKA1qGnO
         7+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=/dJRfHQQv17qvch/geNaWxXrNWhf1Bv8zhSa55DD+9M=;
        b=K+MJ30VZ87pkFQ3IdYgGp4YmIljocLFj/p2y19m1odk3mDIEFhBweOU/tWLC0+GnzW
         IknxmRnnnpbFaFv1GLpU095IpX82frwijkJSLQQ14o6wgVVsUkkCDCPnYcExMEwDrYKb
         IErX3/UsNh5wrksYDTlWHoSKDxYV4vmM/NHh1qyiBh4FOBRgCSES+x+mVmBEP+h+K72z
         O6HtjIIY9pxNbhAi9P/DtO3rHOSaJLt9xHeu5J/NG5YpeOvTxI0yJD3oKXBAc1y8c5kF
         +Fg6i2fXA/F5XxBp8JGUhJDA/efnmEqzTiI6JwvQjXf+ExxhTxNgNHCbfKSGhApnm4wg
         Q2/Q==
X-Gm-Message-State: AD7BkJLqk87O11M9FbJGQYEOkhLd8DwQEp9C0QrDjE/EkDp6+NIgckoUbLkPiz0COX7KF9iJjiiiyydYl7zuyg==
X-Received: by 10.112.173.71 with SMTP id bi7mr1254244lbc.93.1458129847629;
 Wed, 16 Mar 2016 05:04:07 -0700 (PDT)
Received: by 10.112.207.74 with HTTP; Wed, 16 Mar 2016 05:04:07 -0700 (PDT)
In-Reply-To: <CAGZ79kYeYzi=J=dY27FqXp72BRe-Vmm4MR5Q6dFTMUP9CxYZcg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288963>

Hi Stefan,

On Tue, Mar 15, 2016 at 4:30 AM, Stefan Beller <sbeller@google.com> wrote:
> On Sat, Mar 12, 2016 at 2:46 AM, Paul Tan <pyokagan@gmail.com> wrote:
>> These functions can be used for loading and saving common rebase options
>> into a state directory.
>>
>> Signed-off-by: Paul Tan <pyokagan@gmail.com>
>> ---
>>  rebase-common.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  rebase-common.h |  4 ++++
>>  2 files changed, 73 insertions(+)
>>
>> diff --git a/rebase-common.c b/rebase-common.c
>> index 5a49ac4..1835f08 100644
>> --- a/rebase-common.c
>> +++ b/rebase-common.c
>> @@ -26,3 +26,72 @@ void rebase_options_swap(struct rebase_options *dst, struct rebase_options *src)
>>         *dst = *src;
>>         *src = tmp;
>>  }
>> +
>> +static int state_file_exists(const char *dir, const char *file)
>> +{
>> +       return file_exists(mkpath("%s/%s", dir, file));
>> +}
>
> How is this specific to the state file? All it does is create the
> leading directory
> if it doesn't exist? (So I'd expect file_exists(concat(dir, file)) to
> have the same
> result without actually creating the directory if it doesn't exist as
> a side effect?

I don't quite understand, AFAIK mkpath() does not create any
directories as a side-effect. And yes, I just wanted a short way to
say file_exists(concat(dir, file)) or file_exists(mkpath("%s/%s", dir,
file)) without cluttering up the code.

> If the dir doesn't exist it can be created in rebase_options_load explicitly?

I don't intend to create any directories if they do not exist.

>> +
>> +static int read_state_file(struct strbuf *sb, const char *dir, const char *file)
>> +{
>> +       const char *path = mkpath("%s/%s", dir, file);
>> +       strbuf_reset(sb);
>> +       if (strbuf_read_file(sb, path, 0) >= 0)
>> +               return sb->len;
>> +       else
>> +               return error(_("could not read '%s'"), path);
>> +}
>> +
>> +int rebase_options_load(struct rebase_options *opts, const char *dir)
>> +{
>> +       struct strbuf sb = STRBUF_INIT;
>> +       const char *filename;
>> +
>> +       /* opts->orig_refname */
>> +       if (read_state_file(&sb, dir, "head-name") < 0)
>> +               return -1;
>> +       strbuf_trim(&sb);
>> +       if (starts_with(sb.buf, "refs/heads/"))
>> +               opts->orig_refname = strbuf_detach(&sb, NULL);
>> +       else if (!strcmp(sb.buf, "detached HEAD"))
>> +               opts->orig_refname = NULL;
>> +       else
>> +               return error(_("could not parse %s"), mkpath("%s/%s", dir, "head-name"));
>> +
>> +       /* opts->onto */
>> +       if (read_state_file(&sb, dir, "onto") < 0)
>> +               return -1;
>> +       strbuf_trim(&sb);
>> +       if (get_oid_hex(sb.buf, &opts->onto) < 0)
>> +               return error(_("could not parse %s"), mkpath("%s/%s", dir, "onto"));
>> +
>> +       /*
>> +        * We always write to orig-head, but interactive rebase used to write
>> +        * to head. Fall back to reading from head to cover for the case that
>> +        * the user upgraded git with an ongoing interactive rebase.
>> +        */
>> +       filename = state_file_exists(dir, "orig-head") ? "orig-head" : "head";
>> +       if (read_state_file(&sb, dir, filename) < 0)
>> +               return -1;
>
> So from here on we always use "orig-head" instead of "head" for
> interactive rebase.
> Would people ever rely on the (internal) file name and have e.g.
> scripts which operate
> on the "head" file ?

This backwards-compatibility code is just a straight port from the
code in git-rebase.sh.

The usage of orig-head has been around since 2011 with 84df456
(rebase: extract code for writing basic state, 2011-02-06), so I guess
if people had issues with it, it would have been reported.

>
>
>> +       strbuf_trim(&sb);
>> +       if (get_oid_hex(sb.buf, &opts->orig_head) < 0)
>> +               return error(_("could not parse %s"), mkpath("%s/%s", dir, filename));
>> +
>> +       strbuf_release(&sb);
>> +       return 0;
>> +}
>> +
>> +static int write_state_text(const char *dir, const char *file, const char *string)
>> +{
>> +       return write_file(mkpath("%s/%s", dir, file), "%s", string);
>> +}
>
> Same comment as on checking the state files existence. I'm not sure if the side
> effect of creating the dir is better done explicitly where it is used.
> The concat of dir and
> file name can still be done in the helper though? (If the helper is
> needed at all then)

Same as above -- AFAIK I don't think mkpath() creates any directories
as a side-effect.

>
>> +
>> +void rebase_options_save(const struct rebase_options *opts, const char *dir)
>> +{
>> +       const char *head_name = opts->orig_refname;
>> +       if (!head_name)
>> +               head_name = "detached HEAD";
>> +       write_state_text(dir, "head-name", head_name);
>> +       write_state_text(dir, "onto", oid_to_hex(&opts->onto));
>> +       write_state_text(dir, "orig-head", oid_to_hex(&opts->orig_head));
>> +}
>> diff --git a/rebase-common.h b/rebase-common.h
>> index db5146a..051c056 100644
>> --- a/rebase-common.h
>> +++ b/rebase-common.h
>> @@ -20,4 +20,8 @@ void rebase_options_release(struct rebase_options *);
>>
>>  void rebase_options_swap(struct rebase_options *dst, struct rebase_options *src);
>>
>> +int rebase_options_load(struct rebase_options *, const char *dir);
>> +
>> +void rebase_options_save(const struct rebase_options *, const char *dir);
>> +
>>  #endif /* REBASE_COMMON_H */
>> --
>> 2.7.0

Thanks,
Paul
