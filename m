From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4] upload-pack.c: use of parse-options API
Date: Fri, 27 May 2016 12:59:14 -0400
Message-ID: <CAPig+cRipGvwqXQhY1koOLR2h=VcHqrTMhp_zbphYtaabQ0qAw@mail.gmail.com>
References: <20160523130231.8725-1-Antoine.Queru@ensimag.grenoble-inp.fr>
	<20160527141628.1677-1-Antoine.Queru@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	William Duclot <william.duclot@ensimag.grenoble-inp.fr>,
	simon rabourg <simon.rabourg@ensimag.grenoble-inp.fr>,
	francois beutin <francois.beutin@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Antoine Queru <Antoine.Queru@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri May 27 18:59:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6L6Z-0002sT-N0
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 18:59:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756256AbcE0Q7T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2016 12:59:19 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:35860 "EHLO
	mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755243AbcE0Q7P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2016 12:59:15 -0400
Received: by mail-it0-f41.google.com with SMTP id e62so162399ita.1
        for <git@vger.kernel.org>; Fri, 27 May 2016 09:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=bDCp2bgRTVCzQcMEi78OAdl7mmGZPao1Nk5mV2kIRds=;
        b=cO3emJ2G57bHaZ+UPavRS7OT3IlVltFKhGLaHloqhu5/mr3DcyiQu899vEaUh2lKPv
         Qh1xQ/z5YoRbgHxvMoA97HvaEjhM9WUOHFm4/ShZe62W6BrfPU/4Ynoc6NrkbwJId6XZ
         VG2w42sPc3VcjlHvlvnBT/5CwcCoPeFcikwCkQucnio5u1EVVmB1RF2UaQwcoDULC+Ge
         SxoEvVPwwtXqmIQWCRPNt+Xr8HS46eBGpISMvhsNVnB1hVgH9dCwJgDlHdansqQ0FoMT
         L4KSlfQ5RUAzUHmRe/ITzROJBebLnvbpWB6PGDbiG9QgjyDiMPOAkf6zK57VB7+AnndL
         EbUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=bDCp2bgRTVCzQcMEi78OAdl7mmGZPao1Nk5mV2kIRds=;
        b=duvxv+mcsak+Hl0l/MBX1EsOoseXdL+qBeEtucNEtvTsd4QijSn3udpDuNcqWEEYdv
         6pOsshITFgEQSNFHAymgswmAZHfIxZ0Kn/LANXYP5r+hzYeYDpYLoekZP7UzLveDaXTB
         zZIh7xtgpsGzlSiEvn50HjFI+7eov0igtNDa7Ltbi+UyeT4Y0Hailo9BHtERNxQPrKyH
         Y82agDM3T/q0RDFFOlwbPg8EI+4y0XaiYgSgE9tzLwxLn+Yq9Y0XP+qsP8r0nr9KBUjn
         iD0gR7NhNaUeYOVlEHnWwp9DgOKtLs9QTnNNcPnUagkjyqzq5fU20RUXnL9FbpyVZdku
         lySw==
X-Gm-Message-State: ALyK8tK3ioZJDm9FL2vqPZlFq9svXbjwWE6C3zRIewPGD0Pvcw60DdbqrIBaGhwijlsK2nPq1ANWH1v4Msg0hQ==
X-Received: by 10.36.69.33 with SMTP id y33mr9048714ita.84.1464368354093; Fri,
 27 May 2016 09:59:14 -0700 (PDT)
Received: by 10.79.110.21 with HTTP; Fri, 27 May 2016 09:59:14 -0700 (PDT)
In-Reply-To: <20160527141628.1677-1-Antoine.Queru@ensimag.grenoble-inp.fr>
X-Google-Sender-Auth: jYSxyxx0S2ke8GkjGwaoT-aezIM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295769>

On Fri, May 27, 2016 at 10:16 AM, Antoine Queru
<Antoine.Queru@ensimag.grenoble-inp.fr> wrote:
> upload-pack.c: use of parse-options API

Matthieu already mentioned that this should use imperative mood:

    upload-pack: use parse-options API

> Option parsing now uses the parser API instead of a local parser.
> Code is now more compact.

Imperative:

    Use the parse-options API rather than a hand-rolled
    option parser.

That the code becomes more compact is a nice result of this change,
but not particularly important, thus not really worth a mention in the
commit message.

> Description for --stateless-rpc and --advertise-refs come from
> the commit 42526b4 (Add stateless RPC options to upload-pack,
> receive-pack, 2009-10-30).

s/from the commit/from/

> Signed-off-by: Antoine Queru <antoine.queru@grenoble-inp.fr>
> Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> ---
> diff --git a/Documentation/git-upload-pack.txt b/Documentation/git-upload-pack.txt
> @@ -31,6 +31,19 @@ OPTIONS
> +--stateless-rpc::
> +       the programs now assume they may perform only a single read-write

s/the/The/

Also, to what "programs" does this refer? And what does "now" mean here?

> +       cycle with stdin and stdout. This fits with the HTTP POST request
> +       processing model where a program may read the request, write a
> +       response, and must exit.
> +
> +--advertise-refs::
> +       When --advertise-refs is passed as a command line parameter only

The entire "When ... parameter" bit is redundant, isn't it? Why not
just say "Perform only..."?

> +       the initial ref advertisement is output, and the program exits
> +       immediately.  This fits with the HTTP GET request model, where
> +       no request content is received but a response must be produced.
> +
> +

Style: Drop the extra blank line.

>  <directory>::
>         The repository to sync from.
>
> diff --git a/upload-pack.c b/upload-pack.c
> @@ -817,11 +821,21 @@ static int upload_pack_config(const char *var, const char *value, void *unused)
> -int main(int argc, char **argv)
> +int main(int argc, const char **argv)
>  {
> -       char *dir;
> -       int i;
> +       const char *dir;
>         int strict = 0;
> +       struct option options[] = {
> +               OPT_BOOL(0, "stateless-rpc", &stateless_rpc,
> +                        N_("quit after a single request/response exchange")),
> +               OPT_BOOL(0, "advertise-refs", &advertise_refs,
> +                        N_("only the initial ref advertisement is output, program exits immediately")),

Possible rewrite: "exit immediately after initial ref advertisement"

> +               OPT_BOOL(0, "strict", &strict,
> +                        N_("do not try <directory>/.git/ if <directory> is no Git directory")),

Use of OPT_BOOL introduces a --no-strict option which didn't exist
before. Does this need to be documented? (Genuine question.)

> +               OPT_INTEGER(0, "timeout", &timeout,
> +                           N_("interrupt transfer after <n> seconds of inactivity")),
> +               OPT_END()
> +       };
