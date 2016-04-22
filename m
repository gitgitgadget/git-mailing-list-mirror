From: Stefan Beller <sbeller@google.com>
Subject: Re: issue upgrading git from 1.8.2.1 to 2.8.0
Date: Fri, 22 Apr 2016 15:48:49 -0700
Message-ID: <CAGZ79kYt_D7F3Uq_bhDpJa6Hnc1xfazhU1oree_nM0xbgROqsQ@mail.gmail.com>
References: <CA+UAp04e9-CcUJ+2fheHGw1q6MS6smyHhvyw34NeoT7HbKgnnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Gennaro Torre <gtorre@tumblr.com>
X-From: git-owner@vger.kernel.org Sat Apr 23 00:48:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atjsd-0007K6-4n
	for gcvg-git-2@plane.gmane.org; Sat, 23 Apr 2016 00:48:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752201AbcDVWsv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 18:48:51 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:36156 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751618AbcDVWsu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 18:48:50 -0400
Received: by mail-ig0-f178.google.com with SMTP id f1so29376415igr.1
        for <git@vger.kernel.org>; Fri, 22 Apr 2016 15:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=ZvoSoUMubjrbrZQpbpagRKzux5F2LS7cp7TG6bcGu4Q=;
        b=E0KN8lCWFgbirot03izoZw0rLLoi/94V4/3pz9G8brPV8Gb+s6F/9WQNCm7EtJ4NzB
         WFBXBt/qlCReKj8hS3FZUlC59AjisWpIJVMOtRIHSllYaEskhGq3Tzr457jea1yvJO7b
         SWs1TLcFk5r2m387s3LNBMPTXZ8AVNiGPQJMXvCkOXMSPuBY/Jn2SM2rizcMimuAgbM8
         fQpCWQNM3Dofh0so5FhEEvvyyi5uwNak36LAjbI1ZLZG4Bg8Rk/zbyEu8wkoFVaWIVIz
         cEtFK1tiROm9ql1TbKdQB161pkrMJ4w3+5YP2BvGpJGObrWguoNtFvKKRvj3Q/7QynDZ
         tucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=ZvoSoUMubjrbrZQpbpagRKzux5F2LS7cp7TG6bcGu4Q=;
        b=iVsx50YIiKYXkqg3rwLCpX29UGNbWjLV6rdlVK7RKuf3td30Npwp1CyGHDhSjtr4eV
         cgkB0y4w7Kps8aXzqr+FNKX8HEyWsdjc7tLEkBgzHaNBwoWl4pxoUh5/FPiX4z3uWCdD
         laHlW7sS+Wi5JLl1I6u7x4F5ltr5FB+Sf8rjkU2lN0GeQ1WzAjsO7PrbLftkT/TB1rZW
         ISexTAOGBVcfLlz+JB5Wl53swO+TsSnKnjyyukHEo0AfE8VMCWOKP91aG8g2Q/UoSH6/
         IaMEqarRJKZrx3szc+hxykuhAbbEkPRvJAg0zSU5MiLHyHuP+h/dmU5ZcrWtVAKbsHHl
         eeAA==
X-Gm-Message-State: AOPr4FXOp+eUqa+J3DEpjo96Z5rd1lb/IcXLAGDsziprbf6h2kbOUAF5cONmyj7PgAd50GbZCKygLX4kpVxCz63A
X-Received: by 10.50.98.195 with SMTP id ek3mr18531igb.85.1461365329415; Fri,
 22 Apr 2016 15:48:49 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Fri, 22 Apr 2016 15:48:49 -0700 (PDT)
In-Reply-To: <CA+UAp04e9-CcUJ+2fheHGw1q6MS6smyHhvyw34NeoT7HbKgnnQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292287>

On Fri, Apr 22, 2016 at 3:44 PM, Gennaro Torre <gtorre@tumblr.com> wrote:
>
> Hi,
>
> Last week we upgraded git from 1.8.2.1 to 2.8.0. We saw some very
> weird behavior where git clones and pushes were working, but git fetch
> was not.
>
> Here is our setup:
>
> We have 10+ nodes caching a few repositories, the repos were
> originally cloned via git 1.8.2.1 with `git clone --mirror <repo>`
>
> We have 3000+ nodes that take deploys using the git protocol, via `git
> fetch`, the existing repositories were also cloned via git 1.8.2.1
> from the caching nodes.
>
> When we upgraded to 2.8.0, all nodes received the upgrade.
>
> We observed that when we tried to deploy code to the nodes (they run
> `git fetch` to update the repository) this would fail.
>
> The fix: we deleted the repositories originally cloned via git
> 1.8.2.1, and did a `git clone <repo>` dropping a fresh repository that
> was cloned using git 2.8.0. Everything started working correctly. Our
> running theory here is that there was some incompatibility with the
> repositories cloned with the old version of git, and trying to run
> `git fetch` with the newest version of git.

Do you still have an old repository?
You could compare a new and old repository with e.g. meld
to see if there are differences you don't expect.

Although 1.8..2.8 is a lot, Git ought to stay compatible there.

Thanks,
Stefan

>
>
> Thanks,
> Gennaro
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
