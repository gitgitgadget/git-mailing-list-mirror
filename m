From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH/RFC/GSoC 09/17] rebase-common: implement cache_has_unstaged_changes()
Date: Tue, 15 Mar 2016 18:07:35 +0700
Message-ID: <CACsJy8BOZsPcEgOLiBo4u4SAEzDVmFd_XgU3yq4P+rBGRyJx8w@mail.gmail.com>
References: <1457779597-6918-1-git-send-email-pyokagan@gmail.com>
 <1457779597-6918-10-git-send-email-pyokagan@gmail.com> <alpine.DEB.2.20.1603142151230.4690@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Paul Tan <pyokagan@gmail.com>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>, sam.halliday@gmail.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 15 12:08:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afmpo-0004wv-1Q
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 12:08:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755329AbcCOLIK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 07:08:10 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:36336 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754777AbcCOLIH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 07:08:07 -0400
Received: by mail-lb0-f178.google.com with SMTP id x1so17550548lbj.3
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 04:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vIaDi2fd+O+gGC9ywzQynPo6zi+Y4EJZyovRKp8Z8+A=;
        b=nsnpGZfi+UZkQroN7SW91cgAUk4ExIRt1zxyV7gNdmrkBzrrSIntrmpcVO1NEXV565
         xrsZWiyjmPG6rGyf9hOxjXG7UtTJoxYCLNvpGfDLosLPiY9rGvUF6/wYonBm0PSj+/e9
         2ciUYZ3rgHF3E5AOijI2xBKAzrBmmEKA0WtH5hWigD+hxIEvQYnYTNe4tRNugzFDTirT
         hXxBESXXKNuTdBuHYwl9hPyoIH70lQi/4EkxQmq/HPeGTWl6sZXDfe8gDGxOV0S6rJoD
         h29sgTKSj8xU2vByvKa8xC/02sz9zqxU4WtIg3DXktXNPG6NEh8gPMtRiZLVrqAR/HQ2
         pv+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vIaDi2fd+O+gGC9ywzQynPo6zi+Y4EJZyovRKp8Z8+A=;
        b=bGk+Wgzrgo2xzt/9xEge7Ika0bQarK1azrqvuZDX5iaD4IIb0bZAkItXOZU/X1/H3P
         FoljRaclKyrIGD8Ph6TOWwOv717B7y0cUffUH9VxQjZUM11NTgMXTrpjLjTMOnSiZk9b
         oISf+SUSTuUDRzjUZSwCXKjZuYmHmHPyzz1zPjmN/CCNM2CSlESGz3i8H9m54LWxVuzG
         mepStMziQhxR1hyxuHxh6nmNSXRIEx+GIz3ZR6vGQC9jL5tWFyREiYBT9+fq9eYiW0/9
         1pl2gqAQEl20dHSgVgkc0L6TdiCV2GUh6XOUr3JWRmAUrZtcyUsPwMsFQDizhcskb7Ge
         VH8g==
X-Gm-Message-State: AD7BkJJ4wYUWumTxAJlAIcXdE2Q9Vzcv/hVUgHlh8nRP8VNyYldbokDgzerpeIi0SZZlqF1m9/t3SB1h/IhJxw==
X-Received: by 10.25.159.68 with SMTP id i65mr9571192lfe.94.1458040084885;
 Tue, 15 Mar 2016 04:08:04 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Tue, 15 Mar 2016 04:07:35 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1603142151230.4690@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288846>

On Tue, Mar 15, 2016 at 3:54 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> In my 'interactive-rebase' branch...

64 commits! Maybe next time we should announce wip branches like this
when we start doing stuff so people don't overlap. Of course these
branches do not have to be perfect (and can be force pushed from time
to time, even).
-- 
Duy
