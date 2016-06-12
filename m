From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: lib-httpd/apache.conf and mod_unixd.so
Date: Sun, 12 Jun 2016 21:20:58 +0700
Message-ID: <CACsJy8BSF0PxkHoEXkW7nT4dn2ELnUuQA4VZSNZYgVWwerb-kA@mail.gmail.com>
References: <CACsJy8D8e2R9YZGGFQR-AC0OtWWYriuJoTmvtG4VuqdfPZGXeQ@mail.gmail.com>
 <20160612130044.GB15289@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jun 12 16:21:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bC6Gh-00060l-St
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jun 2016 16:21:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752280AbcFLOVa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jun 2016 10:21:30 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:35937 "EHLO
	mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750924AbcFLOV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jun 2016 10:21:29 -0400
Received: by mail-it0-f43.google.com with SMTP id a5so30495817ita.1
        for <git@vger.kernel.org>; Sun, 12 Jun 2016 07:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sbaCtc87VTFxSrf/lZ1rZkc2ZqWxquWKBfowGsI5L6M=;
        b=w/FaU4JYvxuMnll4S/+TKkScQcNlK/2uMgNty38kc43mceGDaF6HQWvjrDhi7DVkvy
         w8IWD86r+6hAHiZIPIRyZDeqVBker3LVqmA4D7h/m+2pqO/zQINZllcPA/RM7iOU1Rpp
         Z3aHiT+YQVbjzm9JZuf8rdIuc4uTlz8SbPbwwIjmRCo7ECgoMIfbahATn3arOX+ymYwE
         pGeDAfBMf+zGIjUMhSebdeRgOX/eRUQyWngsiNEFYndvF1kBSUQXgj/U5H8YMRiZQSZP
         bVVW8wqdISOmHdK3Nbf/9hQ3CFCPMEWqeUb6zDuHp82vRTX7HhlI5yZdXJ2oED/9qs95
         4O7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sbaCtc87VTFxSrf/lZ1rZkc2ZqWxquWKBfowGsI5L6M=;
        b=jvXjXNb5D+6EnMEDhEQpDtz1iOyLaxxNyiIuk++EEgu9XfZBGrBW80ZeoR5MQ9/s6y
         b/l2UHrm0gJfnBRUwr3fcdHzSqbAN6Xm6WHhca0DQj1AqEs+jRPJry5nv0xuvvi4O5b+
         YXSgrJycfIcPKQgEr59+weAKGk8yrlXpqFitzrkU7OiYsQONJeEO8XObiubGh9WG9sSg
         kG/02EemPeNVkrXHrk9u1oWK31w5srqBM6iaW6TClZVXAmbWLA81L9FOJopC9cJigfgr
         FM0xvAG/h6NtA4Dul14wQQP99lKNCrsbZdFCFHe6mNOJqEZCWsyaG3oq7PDkqA30K0P2
         s0lg==
X-Gm-Message-State: ALyK8tKj2eZBH/bQK/6zwK/LrMgCVIs/rhuQC9K8wyNTZzJoRROh2zWCVG2/k/hJXogfw0vgb5xghuXstIsZWQ==
X-Received: by 10.36.130.130 with SMTP id t124mr11433568itd.42.1465741288377;
 Sun, 12 Jun 2016 07:21:28 -0700 (PDT)
Received: by 10.64.173.167 with HTTP; Sun, 12 Jun 2016 07:20:58 -0700 (PDT)
In-Reply-To: <20160612130044.GB15289@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297138>

On Sun, Jun 12, 2016 at 8:00 PM, Jeff King <peff@peff.net> wrote:
> On Sun, Jun 12, 2016 at 05:48:42PM +0700, Duy Nguyen wrote:
>
>> A quick search shows that loading mod_unixd.so will do (and did make
>> httpd run for me). Problem is, can I just update apache.conf to load
>> it when apache version >= 2.4? I don't know if doing that would cause
>> failure for other people because mod_unixd has existed since 2.2 and
>> people have run httpd tests fine so far...
>
> Are you running a version that has 5922322 (t/lib-httpd: load mod_unixd,
> 2015-05-11)?

Nope. This is nd/shallow-deepen which has a really old base. Good to
know it's already fixed.
-- 
Duy
