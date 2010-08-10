From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] fast-import: export correctly marks larger than 2^20-1
Date: Tue, 10 Aug 2010 07:20:19 -0700
Message-ID: <AANLkTiniC0JeeZZeYSTg7M6WuhzJzChiqZ+9EBMoZwxQ@mail.gmail.com>
References: <1279021908-21291-1-git-send-email-harinath@hurrynot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Raja R Harinath <harinath@hurrynot.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 10 16:20:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oiph7-0000HJ-IA
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 16:20:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101Ab0HJOUl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Aug 2010 10:20:41 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:40274 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757545Ab0HJOUk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Aug 2010 10:20:40 -0400
Received: by pvg2 with SMTP id 2so1194219pvg.19
        for <git@vger.kernel.org>; Tue, 10 Aug 2010 07:20:39 -0700 (PDT)
Received: by 10.142.148.10 with SMTP id v10mr14952562wfd.105.1281450039443; 
	Tue, 10 Aug 2010 07:20:39 -0700 (PDT)
Received: by 10.142.78.19 with HTTP; Tue, 10 Aug 2010 07:20:19 -0700 (PDT)
In-Reply-To: <1279021908-21291-1-git-send-email-harinath@hurrynot.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153111>

On Tue, Jul 13, 2010 at 4:51 AM, Raja R Harinath <harinath@hurrynot.org=
> wrote:
> dump_marks_helper() has a bug when dumping marks larger than 2^20-1,
> i.e., when the sparse array has more than two levels. =A0The bug was
> that the 'base' counter was being shifted by 20 bits at level 3, and
> then again by 10 bits at level 2, rather than a total shift of 20 bit=
s
> in this argument to the recursive call:
>
> =A0(base + k) << m->shift
>
> There are two ways to fix this correctly, the elegant:
>
> =A0(base + k) << 10
>
> and the one I chose due to edit distance:
>
> =A0base + (k << m->shift)
>
> Cc: Shawn O. Pearce <spearce@spearce.org>
> Signed-off-by: Raja R Harinath <harinath@hurrynot.org>

Dang, that's a very old bug.  This change makes sense, thanks.

Acked-by: Shawn O. Pearce <spearce@spearce.org>

--=20
Shawn.
