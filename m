From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v2 16/21] refs: check submodules ref storage config
Date: Wed, 13 Jan 2016 11:32:46 -0500
Organization: Twitter
Message-ID: <1452702766.16226.0.camel@twopensource.com>
References: <1452561740-8668-1-git-send-email-dturner@twopensource.com>
	 <1452561740-8668-17-git-send-email-dturner@twopensource.com>
	 <xmqqtwmiqqk9.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 17:33:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJOLw-0007PR-4n
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 17:32:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753968AbcAMQcw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 11:32:52 -0500
Received: from mail-qk0-f178.google.com ([209.85.220.178]:34813 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752929AbcAMQcu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 11:32:50 -0500
Received: by mail-qk0-f178.google.com with SMTP id t64so37225348qke.1
        for <git@vger.kernel.org>; Wed, 13 Jan 2016 08:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=WH1g8tH1y/h0ypAJ16QedT+LpeV5u7ukhK7dyGqECwY=;
        b=pLu83KZSZ2RdXXqIvq4t1YAKAmeylXp/2cRJUDS7JV/yy9UNWOvIHVvybH69C265Ul
         XnghZPThEkRbbmh2Mj/0EEM0iGnQDNNALQUhPemUSHaigm/0T5tR3txf56GgMAHjKDFb
         QALqnEemruMA+MjaBdA95M8LMefOWox5dLonn/JBaoR8zuzksX7KK3ZmjAowAWZ+S2eY
         N3+ocSTzHwKBM1i09D4CDwoU0Fy0wZ71io4mLvegWl+nwxqRHIdpHZLXsDX3IVkGpo+Y
         HUJNvGr7bGAORZtu/6f8OiS2eKoLFx4zJvY7S02a7R1VdRMZWCdZGIssVXAd1PyasBxO
         iaKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=WH1g8tH1y/h0ypAJ16QedT+LpeV5u7ukhK7dyGqECwY=;
        b=KRpz6q9gYVnxRnFlGYkLvVmjAyluv73pg6N4AwFSyQNSJ4kg8jvJeVaufWOEgqMd+k
         B1kUFcEJHdRK52fdNXAtiuGDUpVoQB+9igfYZ/J530iL0AJs7P+fSg17dO8Z3+ubM5X9
         0q/MvaRdtFc+E/yq43iI65VLiXYpbwS/VMhib/P07mG4caN7FYwJ0bVAVrbEkLKVaJYn
         CkksBQ47AKfQji9MngInHYM/wmvBvP8LmogyI58MMyoEV7C3ykWkzPs+nmrdYhkKKCHv
         t+cjROQ15Wktoxf2L/Bb83n/lbKFYLXLOiXABjpAlPYE+M+Cf9mFVfMpPnhe2cfDXciX
         t6Lg==
X-Gm-Message-State: ALoCoQknntAcvckA1KscY78tZkBfIjbgP4efjjvJmuLQGfDNZxI2x4J0XdYZ4HJ5FEP2jcyoTX7XiCuv4ZytksZObpI87nnwNw==
X-Received: by 10.55.76.84 with SMTP id z81mr87990673qka.17.1452702767988;
        Wed, 13 Jan 2016 08:32:47 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id j69sm777710qkh.21.2016.01.13.08.32.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Jan 2016 08:32:47 -0800 (PST)
In-Reply-To: <xmqqtwmiqqk9.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283925>

On Tue, 2016-01-12 at 16:19 -0800, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> > All submodules must have the same ref storage (for now).  Confirm
> > that
> > this is so before attempting to do anything with submodule refs.
> > 
> > Signed-off-by: David Turner <dturner@twopensource.com>
> > ---
> >  refs.c | 41 +++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 41 insertions(+)
> > 
> > diff --git a/refs.c b/refs.c
> > index 07f1dab..1ccc7f6 100644
> > --- a/refs.c
> > +++ b/refs.c
> > @@ -297,8 +297,43 @@ int for_each_tag_ref(each_ref_fn fn, void
> > *cb_data)
> >  	return for_each_ref_in("refs/tags/", fn, cb_data);
> >  }
> >  
> > +static int submodule_backend(const char *key, const char *value,
> > void *data)
> > +{
> > +	char **path = data;
> > +	if (!strcmp(key, "extensions.refstorage"))
> > +		*path = xstrdup(value);
> > +}
> 
> This should return "int" (namely 0).

Fixed, thanks.
