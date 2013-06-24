From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/6] push: change `simple` to accommodate triangular workflows
Date: Mon, 24 Jun 2013 19:43:12 +0530
Message-ID: <CALkWK0mC_SDR=wdPHkM5YBUXi3ntfBXfmVF468Nt_Ssembuntg@mail.gmail.com>
References: <1372048388-16742-1-git-send-email-gitster@pobox.com>
 <1372048388-16742-4-git-send-email-gitster@pobox.com> <CALKQrgfAT9GhD-_tZHr9wRA6R6g7ttDWTsmUQXdWUhG-gwNBqQ@mail.gmail.com>
 <CALkWK0mAyDb3AjH0s3j2gRRDckx=a2nr9MR+O6gEtwX2MSJrtw@mail.gmail.com> <CALKQrgfCR10nfP9tVuHyhCPOfe3XVvBzzQayhM7b9Ra5ZDGnMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Jun 24 16:13:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur7Wn-0003EC-Et
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 16:13:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242Ab3FXONx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 10:13:53 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:41630 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875Ab3FXONx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 10:13:53 -0400
Received: by mail-ie0-f182.google.com with SMTP id s9so25120283iec.27
        for <git@vger.kernel.org>; Mon, 24 Jun 2013 07:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=g70jrQPHxpgyhn4nnw6z8nad04WaUJFsd6J3AQtNhdY=;
        b=xsKkGcAhFBRpVtsjMQdi89LJq7uJ6DHnHUj2rhzsXRzf4KkzJ0DT3qgl8u6YCPc4Es
         qDDidHAEkLxhbi9kWHBrkVztbs8xRon8SMRvM2y+lhpbGVlzHySQHVFMCPEWCt15Pn9n
         WiM1ugB+ad4mosYIFqdMyy/D/cpPKPs0oDvcUaTtMfh+kgs3xGYBFxznD99aiBsd3T89
         9xW/nJqkwD/cKNlozVpq5mkqWvyCYHQnyuYfx/gQuK+RgQ7ThzDODBeXUssBsT/5Fmtn
         o7ifLktymAYULfukY7hdfUvl/xU1hZbK40bhvFSfYL8jiT1tWjkpBQhweidVn2kbzyNh
         7O9Q==
X-Received: by 10.50.66.130 with SMTP id f2mr5619911igt.55.1372083232679; Mon,
 24 Jun 2013 07:13:52 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Mon, 24 Jun 2013 07:13:12 -0700 (PDT)
In-Reply-To: <CALKQrgfCR10nfP9tVuHyhCPOfe3XVvBzzQayhM7b9Ra5ZDGnMw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228814>

Johan Herland wrote:
> But then, does it make sense to
> say that we will only ever have exactly _one_ push refspec in the
> current context, and we should therefore replace the "static const
> char **refspec;" string array with a single "static const char
> *refspec;" string? That would make it obvious that there is no room
> for ambiguity with overlapping refspecs.

Multiple refspecs can be specified on the command-line; set_refspecs()
is responsible for calling add_refspec() multiple times for each
refspec, and _that_ is the primary use of the "refspec" variable.  The
single add_refspec() invocation in the push.default switch is a
special case that reuses the variable.
