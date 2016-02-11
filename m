From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: RFC: Resumable clone based on hybrid "smart" and "dumb" HTTP
Date: Fri, 12 Feb 2016 06:53:42 +0700
Message-ID: <CACsJy8DLYjXW1VBsxLYwcpjFV2s3MKqw9FL_2S7dMXpZigc2kA@mail.gmail.com>
References: <CAJo=hJtHgE_vye_1sPTDsvJ0X=Cs72HKLgRH8btpW-pMrDdk9g@mail.gmail.com>
 <CAJo=hJuRxoe6tXe65ci-A35c_PWJEP7KEPFu5Ocn147HwVuo3A@mail.gmail.com>
 <CAGZ79kZMvxa5Np4GbShv_A6NZwVAqff94+d8MFTZwrZS+2CqeQ@mail.gmail.com> <20160210210115.GA10155@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 12 00:54:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aU13x-0000C7-G9
	for gcvg-git-2@plane.gmane.org; Fri, 12 Feb 2016 00:54:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467AbcBKXyP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 18:54:15 -0500
Received: from mail-lf0-f43.google.com ([209.85.215.43]:35362 "EHLO
	mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751273AbcBKXyN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 18:54:13 -0500
Received: by mail-lf0-f43.google.com with SMTP id l143so42119171lfe.2
        for <git@vger.kernel.org>; Thu, 11 Feb 2016 15:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=28jtkRtLPr7CcbK1xwLEyCPbfngwUvZt5qMCcCZpivc=;
        b=o8xuZcMod7ZkeyuqGle0b3iSir0YVvpxtQUnF7pkV7BLVbgbCsGzMYyj5dOB4CJtZQ
         2fgo+JIZLX0LF9WXYZQDfkd01n36TfqLHuVTJzVAwXFkQQo6PUi600iiecF+jRnSkLqx
         g8zlEsJpdW6dwwuuaIVco8IjN/omX8MAKk7P5jy+oEPIpqr4RLubyATKrsE+mrWEz+55
         +L0ZITXegf8T/IIn1xq1ZB2chIacEu2ocpbu8BahpJkq6X61r0sw4BbZFbernLgDP6vd
         qJ8m6th2gIirimv2cLvG13MQlxjQ9zUGx9OHc3y3Kg9RHRER+UH5Wo7MlZjPL+d2LS99
         5xiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=28jtkRtLPr7CcbK1xwLEyCPbfngwUvZt5qMCcCZpivc=;
        b=nNAWnDNya12O+Yhpx8puYHY0+cJ0XqQmI6Z/MOX6IHc3NWTCFmKkbsifCpZR79NaZ7
         jkVHzD9l1/Q3yVBUztVLxxS98LN/5RmKKcmAMwnjbUkYR1deTuEm8OUv8raXgU9WwFeJ
         t0U0QpdznxKH2OTOCUOfFmFinOE+B6J8Zn2AcXt0+k/iubHU8bIC25zcJrFM3YeODNfa
         g6Jxz0tXq35IHYVLRDEblA4NUwh9g6YuXWX++gVAu8e6hTfNIlxfaNzOWLCMw0UPenaj
         nqN8b9zHgotQLtq9z0NM4uuuJcgltCmGlyFiO+/wOh4vjzhhUNX0vqVro/OlHgjE4dAu
         Mp/g==
X-Gm-Message-State: AG10YOSeC3QOZZNG9S7Enh4qHYH0wu8FMAyDyJwyRutTrpWF/G9iL3UY+rvG/jjLWAqdz5Kh7ikyEDhpjg9lsg==
X-Received: by 10.25.159.68 with SMTP id i65mr9357409lfe.94.1455234851988;
 Thu, 11 Feb 2016 15:54:11 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Thu, 11 Feb 2016 15:53:42 -0800 (PST)
In-Reply-To: <20160210210115.GA10155@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286020>

On Thu, Feb 11, 2016 at 4:01 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> ....
>
> I really like this design.  I'm tempted to implement it (since it
> lacks a bunch of the downsides of clone.bundle).

A bit disappointed we still do not address resumable fetch. But I'm
happy that it makes people excited and one of them even tempted to
implement. This thread sounds like we'll see resumable clone before
2017 :)
-- 
Duy
