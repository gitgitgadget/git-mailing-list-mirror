From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v4 0/3] Make update refs more atomic
Date: Tue, 15 Apr 2014 09:41:31 -0700
Message-ID: <CAL=YDWnWc3r8s2p_SCRDQ+UA9Y9DMRJzG+jcbku2kX0GevC4Dw@mail.gmail.com>
References: <1397500163-7617-1-git-send-email-sahlberg@google.com>
	<xmqqeh0zoe19.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Apr 15 18:41:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wa6Qk-0006Xo-8Y
	for gcvg-git-2@plane.gmane.org; Tue, 15 Apr 2014 18:41:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbaDOQlm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2014 12:41:42 -0400
Received: from mail-ve0-f174.google.com ([209.85.128.174]:35408 "EHLO
	mail-ve0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997AbaDOQlc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2014 12:41:32 -0400
Received: by mail-ve0-f174.google.com with SMTP id oz11so9185894veb.19
        for <git@vger.kernel.org>; Tue, 15 Apr 2014 09:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=y+ZlfQpDeIbfgQun2Pjm1nsEzsi+wSkTNUz5iqJ+acw=;
        b=ZqoyWMSg4KgiRTyLGr3VlK0F1YcUoXOBptVHED3GEcvNGCJX0j9FE56TgVozT4H7p4
         lxTMookTktK7F4M69K73j6tFXvYoN0ko2bmH2m0Zh3OwGfAbGfytTPejNhTQi/BMlcm0
         rKnudA96R827+GxYPGM+aRtI1Nqy3OQBEz8/E+xm+CarKUr9sGn4uTj+TsDrB7BmFWqA
         Lzp9qm+jwfY9zHtVZn9+Jp8mUqbiRIqwLEE+Z/rOxrx9r+fX8wdyR2aecWxkUwZG14Y8
         MlLDDUV3DAlPJjfiP9lJe8KiaSWJPVmDqD1VcJpVhQIIbkgcgy9wHJjZ64QzqffvP7xt
         NO8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=y+ZlfQpDeIbfgQun2Pjm1nsEzsi+wSkTNUz5iqJ+acw=;
        b=cT89gaVflrSeNrQA3+i4E4K63UxsgNc/8bdyu8Q+esBqJd6R/iojBQlHb0Y90H+PeZ
         EPaeMql14WMPSZPp1DP7mfeny6TnXUvXlBJ5gl0Ggli5TakpTh3WeoMCH9+QRANzr/RU
         eA2jF0Tj2hWZQxfsPaA+3h7xS8i089iS01MpIG9je2nDa/qgA/bot7DxpkVkAvrOVajx
         f45RLIZS5PPkCKNmhLG0ZmfQ5lNIryYWd1YbGlGzRN5dbfwHKae2rUqYW2qMzllSidhx
         c8PHDaG8rd8a41jV7Mrlyfhx6t22mpbe6pzp74ksJxU6ez6K9YrumCyAtntGEo5emqmx
         gTqQ==
X-Gm-Message-State: ALoCoQlMfHImQRFcH1uzYsFn6Un9DozPk4AfGPS8WgAoSvLi/IN81EitczS8ZHfCIJ0BByk0DNY6Gc07hGaumbjhGipPJQWz4EINxO67B7dsecT/TrnH9OkrE1towPpgC4S08Os5bEmiYdqtbNhA2bvSNVIURS8ex02t1+NxTur8HawqHn0DcYYEfeHNXKGz7wN/J6Ovaz2v
X-Received: by 10.221.74.200 with SMTP id yx8mr2019700vcb.3.1397580091610;
 Tue, 15 Apr 2014 09:41:31 -0700 (PDT)
Received: by 10.52.141.13 with HTTP; Tue, 15 Apr 2014 09:41:31 -0700 (PDT)
In-Reply-To: <xmqqeh0zoe19.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246289>

On Mon, Apr 14, 2014 at 1:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Thanks; will queue.

Junio,
Please defer queuing for now.

I think we should convert more of the external callers to use
transactions first.
Once that is done and everything uses transactions I will re-send an
updated version of this patch series.


regards
ronnie sahlberg
