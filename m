From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 15/20] init: allow alternate backends to be set for new repos
Date: Thu, 4 Feb 2016 16:48:36 +0700
Message-ID: <CACsJy8DUpOGtZmBr2F2R+8xvzvHOxLc_YOSnF8eQRvHYq15ttA@mail.gmail.com>
References: <1452788777-24954-1-git-send-email-dturner@twopensource.com> <1452788777-24954-16-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 10:49:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRGXX-000800-FY
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 10:49:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753886AbcBDJtL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 04:49:11 -0500
Received: from mail-lb0-f178.google.com ([209.85.217.178]:35586 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753327AbcBDJtH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 04:49:07 -0500
Received: by mail-lb0-f178.google.com with SMTP id bc4so27817713lbc.2
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 01:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=01AsgSRvNKyosezk91X7vPociTGUr+ZhzrFSQswrz5M=;
        b=vude4syeHXZ8ckQZhI5+d01kbyKOF8i6Ws9RSZMdsndiXOzZtscOEh+jus34SaOr8M
         i6vlgfD96XnF6gtnOeKAJDwQFOktTdw/XC2ESAPyh2fp8POWPg7ZEIkY2uCKI7aK18Uy
         RgQEqEigXdw8h0KGrjDDTNUvPFRQEyDWNpbmf42fwy2cJ8+iqkpjKz6eAzkKgLsKRwUs
         gzyZZzUpyqlxR4QLmLOjSS38KHgIYSfGRj1c0KK5nS3KfvdoyAPtVaZxuGBtmcQzRRSc
         UQSizcSsYUWg9DPGyUEsalPOUG4Bt9jpCcGc8KT6m6nU5RzXCp5JEGTztIOiZSsGRgQI
         NIgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=01AsgSRvNKyosezk91X7vPociTGUr+ZhzrFSQswrz5M=;
        b=YB4QO3IqFVvUrVtE4S7RZ6VmTQiur9DXLAFI0waPlVM4iuwn4DAFk++8P9FACvHgkU
         Au/S+VW7ihIJjRGlkVJimXxPqPiB2eNL7qPf7k6ecWgJlFS+K5lMndBGfQ/7T1gUW/pB
         JRfDTQrWIyjnvpQ3IrZBOiVVkH8rvp7QiRd/sf69D4NBJe6eXfiULd51Ihob1rraI7tM
         Io6x+ValTPtNkJT2DXmgVcvfndKVIvrhKMFyNCxTMguOQ0QDtBScXEC9KPBokZ3U6vvF
         hTI3Py9t/J0LYxzDwI3D5y8ZIuBXNPGuZh1XSToXQMgsGZq8cuBoOjnqV7/vyODwXFOx
         UbEg==
X-Gm-Message-State: AG10YOSHaLgX3l6y/H5CvodRM29VQzhQb5QebCo3nyICxdb2wdKwZFvr+55yykTZsOYddSsHUrSoeBJtC+C3tQ==
X-Received: by 10.112.12.2 with SMTP id u2mr3003855lbb.145.1454579346238; Thu,
 04 Feb 2016 01:49:06 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Thu, 4 Feb 2016 01:48:36 -0800 (PST)
In-Reply-To: <1452788777-24954-16-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285445>

(picking a random series version because I didn't follow it closely)

On Thu, Jan 14, 2016 at 11:26 PM, David Turner <dturner@twopensource.com> wrote:
> +       if (requested_ref_storage_backend)
> +               ref_storage_backend = requested_ref_storage_backend;
> +       if (strcmp(ref_storage_backend, "files")) {
> +               git_config_set("extensions.refStorage", ref_storage_backend);
> +               git_config_set("core.repositoryformatversion", ref_storage_backend);
> +#ifdef USE_LIBLMDB
> +               register_ref_storage_backend(&refs_be_lmdb);
> +#endif
> +               set_ref_storage_backend(ref_storage_backend);
> +               repo_version = 1;
> +       }
> +
> +       if (refs_init_db(&err, shared_repository))
> +               die("failed to set up refs db: %s", err.buf);
> +

I was surprised that "git init --ref-storage=lmdb abc" ran
successfully even on non-lmdb build. Of course running any commands in
the new repo will fail, suggesting to rebuild with lmdb. But should
"git init" fail in the first place? I see Thomas' comment about this
block, but not sure why it still passes for me. It does not catch
unrecognized backend names either.

Also it would be nice if we could hide #ifdef USE_LIBLMDB (here and in
config.c) away, maybe in refs directory. I imagine a new backend would
need the same set of #ifdef. Spreading them across files does not
sound ideal.
-- 
Duy
