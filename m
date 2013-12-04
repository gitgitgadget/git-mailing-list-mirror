From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Use mongoose to test smart-http unconditionally?
Date: Wed, 4 Dec 2013 10:13:11 -0800
Message-ID: <CAJo=hJuzP=zYsEZvC5ugKaAWPLAcTzmFJxT5PNFKbBEv0ctnDw@mail.gmail.com>
References: <CACsJy8BHnTHRugJoTDGs7h=dF1qQUWyPXYxCU8YsDU57s+5gyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 04 19:16:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoGzm-00037J-CR
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 19:16:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933205Ab3LDSPY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Dec 2013 13:15:24 -0500
Received: from mail-wg0-f44.google.com ([74.125.82.44]:44597 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933066Ab3LDSNe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Dec 2013 13:13:34 -0500
Received: by mail-wg0-f44.google.com with SMTP id a1so13570230wgh.23
        for <git@vger.kernel.org>; Wed, 04 Dec 2013 10:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Kqur3xwCbWOD2OgmqSyz4vKGNpt94OOd48UUPhJ2CE8=;
        b=fTz4NCZ9lAWGrINrT3cQsARZrQq4jX7tn5I1SLu7xq047gARrVXeQTHr5hQfAoR190
         hyOuMNxgEX65kO/oWj+MucyxqesYH+6aigXpaXhQvsRnB/sHxoOB1JhAfU95QGfj++SI
         5xsMy1KA+SQA4zUj/M7Pyj6RxOyyCfJgjIKsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=Kqur3xwCbWOD2OgmqSyz4vKGNpt94OOd48UUPhJ2CE8=;
        b=DErgoFWtj8mvA+MvDcUrKfntT8clunZq7X6fps/gbNUilQj/OGeM+GGwyqZ6FktH2T
         /kkLMm5Rran3kyFn+Yf5dIiE6z0hRn+d+B40DVYYKA1R9SwGratCnRQf7yEFtIvv+QKN
         R3mKvHkZf/breFP056T/4rvs88HakPoaVPbPbRVBzeuaOA+7bnifQboL0U2KyFJ5c1Vj
         3J34VerlJUajw+snSPtETwN3nSNtFCFXdneRTxI5dl6oawl/RoY2B0IGrHgcRiKDzzuy
         j+GZu8gWfSOduHQQW4NUzoWSCGtC3vY0dukFwXGhEoNVkPc7uAoWWpzthq5NonA/ga7A
         h7ew==
X-Gm-Message-State: ALoCoQlCzJ0CYB4e0d9hW2Yec0Q+5CNmKNck95qYdqGbsVggAn+OqC3kTvmmqtRynbpGlW4l4aEG
X-Received: by 10.180.38.35 with SMTP id d3mr8431957wik.2.1386180812028; Wed,
 04 Dec 2013 10:13:32 -0800 (PST)
Received: by 10.227.192.198 with HTTP; Wed, 4 Dec 2013 10:13:11 -0800 (PST)
In-Reply-To: <CACsJy8BHnTHRugJoTDGs7h=dF1qQUWyPXYxCU8YsDU57s+5gyg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238799>

On Wed, Dec 4, 2013 at 2:53 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> I was thinking of an alternative to apache for testing smart-http so
> that most of http tests could always run. Mongoose [1] looks like a
> good candidate to bundle with git. Just one pair of source files,
> mongoose.[ch], a mainloop wrapper and we have an http server. Just
> wondering, do we rely on any apache-specific features? I'm not so
> familiar with lib-httpd.sh..

I don't think we do anything Apache specific in the test suite. It
basically relies on CGI execution, being able to configure a URL to
serve a directory, and making some URLs 404 or 500 so we can emulate a
broken or failing server to test the client behavior in those
conditions. At worst that 404/500 forced failure mode could be handled
by a CGI.

> [1] https://github.com/cesanta/mongoose
