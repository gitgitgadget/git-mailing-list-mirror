From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 1/4] Refactoring: remove duplicated code from transport.c 
	and builtin-send-pack.c
Date: Mon, 15 Feb 2010 11:29:22 +0800
Message-ID: <be6fef0d1002141929x1c0f48eekb7112463110cd275@mail.gmail.com>
References: <1266182863-5048-1-git-send-email-michael.lukashov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michael Lukashov <michael.lukashov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 04:29:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgreK-0008Mc-Cx
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 04:29:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754697Ab0BOD3Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Feb 2010 22:29:24 -0500
Received: from mail-iw0-f201.google.com ([209.85.223.201]:43170 "EHLO
	mail-iw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754598Ab0BOD3X convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Feb 2010 22:29:23 -0500
Received: by iwn39 with SMTP id 39so1798328iwn.1
        for <git@vger.kernel.org>; Sun, 14 Feb 2010 19:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=UNfV1cc+sh8SfsPet1gICYSWKt9pn+hIX5Sz2U1JBW0=;
        b=vOOPjkSsqtpBG6rJOknNWOleSZ9QQrOnXf6hvbK/L+IKfee4HPPxxNaTKAuf1W2bcs
         M2v6XBnSwxy7Z596UaZvpNUJ5jOAj+L7Y+ygGswWEJde2FAjrEgC+Y4YgAoiIfJ1Ac/W
         uCG9WVzVMdE7bM+UHp9vEBp8wlO4/TmOCxmS8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=PGCdv/eoeEmCQ5Q8/p2P8elLp1iyLKJSmj1ktZmyMxyKmUo/qAiIZ1lyNFmLSON5ul
         D10WO5T5jfmscQyQHaDJtDs7KxCZhJdylaZQK4zG/vnSOKUa3VfxQhcTEs8Gi1lnr+Qs
         O3nQQ7qSsZSGuS6vueqtk25NJSELCyWo0KPbU=
Received: by 10.231.146.134 with SMTP id h6mr514295ibv.16.1266204562574; Sun, 
	14 Feb 2010 19:29:22 -0800 (PST)
In-Reply-To: <1266182863-5048-1-git-send-email-michael.lukashov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139963>

Hi,

On Mon, Feb 15, 2010 at 5:27 AM, Michael Lukashov
<michael.lukashov@gmail.com> wrote:
> The following functions are duplicated:
>
> =A0verify_remote_names
> =A0update_tracking_ref
> =A0print_ref_status
> =A0status_abbrev
> =A0print_ok_ref_status
> =A0print_one_push_status
> =A0refs_pushed
> =A0print_push_status
>
> Signed-off-by: Michael Lukashov <michael.lukashov@gmail.com>

strictly speaking, the implementation for these functions are
different. Perhaps you could advertise in the commit message that some
of the functions from builtin-send-pack.c learnt porcelain, even
though it's always off (0).

> diff --git a/builtin-send-pack.c b/builtin-send-pack.c
> index 76c7206..616811a 100644
> --- a/builtin-send-pack.c
> +++ b/builtin-send-pack.c
> [snip]
> @@ -191,37 +191,47 @@ static void update_tracking_ref(struct remote *=
remote, struct ref *ref)
> =A0 =A0 =A0 =A0}
> =A0}
>
> -#define SUMMARY_WIDTH (2 * DEFAULT_ABBREV + 3)

hmm, since this is only used internally by print_ref_status, can't
this stay here rather than being made public in send-pack.h?

--=20
Cheers,
Ray Chuan
