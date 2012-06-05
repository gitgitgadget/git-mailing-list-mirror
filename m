From: David Michael Barr <davidbarr@google.com>
Subject: Re: [RFC 3/4] Add svndump_init_fd to allow reading dumps from
 arbitrary FDs.
Date: Tue, 5 Jun 2012 11:21:05 +1000
Message-ID: <CAFfmPPO3Yvbs0EzMQa2z13ERi6Ocjv3W=8FYaAGPt739bD_qbw@mail.gmail.com>
References: <1338830455-3091-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
	<1338830455-3091-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
	<1338830455-3091-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
	<1338830455-3091-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 05 03:21:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbiSP-0006ZD-NA
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 03:21:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761271Ab2FEBVI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Jun 2012 21:21:08 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:53704 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757581Ab2FEBVH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jun 2012 21:21:07 -0400
Received: by obbtb18 with SMTP id tb18so7994379obb.19
        for <git@vger.kernel.org>; Mon, 04 Jun 2012 18:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding:x-system-of-record;
        bh=PMZ+4RVFmB14sSn5eielfarFbUu4wH7ZoPW7u1J/UDU=;
        b=h3oEoMFV55fBFYbik1M/6nwTBoMYyh8Do6DwmMKXqVBtKtCB2S/cufbXLtdAsZrQ8N
         tzX6W0EbuQkQdwccB1DWs8MZq36GWIUbSJ8xlOouj22VYAvGu53KlqEH3sO3nxFbeVMe
         X9mLZt7peWwnAfvrGh9xPJfa1TSptg3Ix4DNk+WG8Y1wRM/xKMGnX9DFCsU9Qy3gYk+5
         MqdFqFbQ8t4oeo9xlWqNn4pg+ZCWQ9tk50vzoKtG+aw3ZAqXbBErTx1h7xL98mtxhvyt
         +lZgrGsfI5FwPcVT6sCkwCu5dSi+sq2eWqIYRywYfsxu/vQ8rVECMblAB6LaKFna/F9K
         4VJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding:x-system-of-record
         :x-gm-message-state;
        bh=PMZ+4RVFmB14sSn5eielfarFbUu4wH7ZoPW7u1J/UDU=;
        b=i6JyVxKYp6/a15XphtIFUsp1yj+sEBQK46nl/j/WYh8B1ulyhXophBz8mPmrtVcO/z
         A5kWaPD9Rjt/0DlAAKerpg0k/DraCD+aKce8zpOINjAW+ey6w9o8YKJNEKPUYoSJ6Iyf
         QHlph7cSnctj907O2wOvNElSJAFK9qwtogft+53ahtrJBUJGOnJewI1SD/Aas0sYnliS
         XkUpwWHa6Krm9g794bc22+huwHzwmuxXgjA2WEQK/HswvwTVG/8DRKEFqQE/rnScN5kn
         3FAFTyN14ppRbpiBe4D4+kSAQ5KU+zALQ4JWw/yEzPDRlyJLpu6hdtX8+AdNuEW5EHd3
         5ANA==
Received: by 10.60.169.174 with SMTP id af14mr13901285oec.13.1338859265972;
        Mon, 04 Jun 2012 18:21:05 -0700 (PDT)
Received: by 10.60.169.174 with SMTP id af14mr13901274oec.13.1338859265709;
 Mon, 04 Jun 2012 18:21:05 -0700 (PDT)
Received: by 10.60.57.39 with HTTP; Mon, 4 Jun 2012 18:21:05 -0700 (PDT)
In-Reply-To: <1338830455-3091-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
X-System-Of-Record: true
X-Gm-Message-State: ALoCoQlFAnmEz0+kujhua+9MWapxYNPXQB9MH+kkTaVPFQjSv+k7p1bLlMHGbF0urM+ruM/bUrU/g0jju8G55MADwSm7ok/zKKThhNC825z0JvBrOo1EVlkL86HuhmusUO67Bl2IaflEXlo1k4J/+oPSi176+KUmrQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199198>

On Tue, Jun 5, 2012 at 3:20 AM, Florian Achleitner
<florian.achleitner.2.6.31@gmail.com> wrote:
> The existing function only allowed reading from a filename or
> from stdin.
>
> Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.co=
m>
> ---
> =A0vcs-svn/svndump.c | =A0 20 +++++++++++++++++---
> =A0vcs-svn/svndump.h | =A0 =A01 +
> =A02 files changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
> index 0899790..2f0089f 100644
> --- a/vcs-svn/svndump.c
> +++ b/vcs-svn/svndump.c
> @@ -465,10 +465,8 @@ void svndump_read(const char *url)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0end_revision();
> =A0}
>
> -int svndump_init(const char *filename)
> +static void init()
> =A0{
> - =A0 =A0 =A0 if (buffer_init(&input, filename))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return error("cannot open %s: %s", file=
name, strerror(errno));
> =A0 =A0 =A0 =A0fast_export_init(REPORT_FILENO);
> =A0 =A0 =A0 =A0strbuf_init(&dump_ctx.uuid, 4096);
> =A0 =A0 =A0 =A0strbuf_init(&dump_ctx.url, 4096);
> @@ -479,6 +477,22 @@ int svndump_init(const char *filename)
> =A0 =A0 =A0 =A0reset_dump_ctx(NULL);
> =A0 =A0 =A0 =A0reset_rev_ctx(0);
> =A0 =A0 =A0 =A0reset_node_ctx(NULL);
> + =A0 =A0 =A0 return;
> +}
> +
> +int svndump_init(const char *filename)
> +{
> + =A0 =A0 =A0 if (buffer_init(&input, filename))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return error("cannot open %s: %s", file=
name, strerror(errno));

Note: filename is allowed to be NULL here.
This is a bug in the existing code that you just moved.

I suggest moving error printing into buffer_init().
This way the basis for the message is clearer.

=46or bonus points, we should split buffer_init().
Plain buffer_init() should use stdin.
The new buff_init_path() should take a filename.

> + =A0 =A0 =A0 init();
> + =A0 =A0 =A0 return 0;
> +}
> +
> +int svndump_init_fd(int in_fd)
> +{
> + =A0 =A0 =A0 if(buffer_fdinit(&input, in_fd))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return error("cannot open fd %d: %s", i=
n_fd, strerror(errno));
> + =A0 =A0 =A0 init();
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> diff --git a/vcs-svn/svndump.h b/vcs-svn/svndump.h
> index df9ceb0..24e7beb 100644
> --- a/vcs-svn/svndump.h
> +++ b/vcs-svn/svndump.h
> @@ -2,6 +2,7 @@
> =A0#define SVNDUMP_H_
>
> =A0int svndump_init(const char *filename);
> +int svndump_init_fd(int in_fd);
> =A0void svndump_read(const char *url);
> =A0void svndump_deinit(void);
> =A0void svndump_reset(void);
> --
> 1.7.9.5

Otherwise, I like the direction of this patch.

--
David Barr
