From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 06/10] cat-file: add --batch-check=<format>
Date: Wed, 10 Jul 2013 20:21:15 +0530
Message-ID: <CALkWK0=RtB2ddpGhZO0RAjzQXNfxHBE47bnp6KaVFz=Hicj8sw@mail.gmail.com>
References: <20130710113447.GA20113@sigill.intra.peff.net> <20130710114546.GF21963@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 10 16:52:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwvkR-0003GF-4r
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jul 2013 16:52:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754526Ab3GJOv6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jul 2013 10:51:58 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:50658 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754155Ab3GJOv5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jul 2013 10:51:57 -0400
Received: by mail-ie0-f175.google.com with SMTP id a11so8258151iee.6
        for <git@vger.kernel.org>; Wed, 10 Jul 2013 07:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Uth4pIgdND0dSVmm2oDfXtZi74hBXvZCV3O47MdICDY=;
        b=U9dsQcESkHBpOy+fKIyf3dFHfWhQM5+TAOHWlB0itr28L3peJZ7sbyg19jbOIGziN/
         P7jqt7FBquivK6w4qf2SE4T3AWX7nZy3NrShtwOssf3BEnvJeQEc9OrgKfTS9qCWAl7p
         +SAaJ007O6Ujdq7QIjKENMu/a4HhpmIo7YImjZd2zKdwhIEzrWSZGZCVVtDzCh/zFCgf
         Hsu+iPkl2tC08mlT9WHgCBDnal20C77IplsDc9jE3IilizqdbPmdNkuypOhhQgFmwy7/
         J3axrJVFfAVP9GY8mzrtL1zWlzJZrEL9yyq/7DPaLCkhkJMHwmjcTzHFIZJfJ0YSF4IU
         /XOQ==
X-Received: by 10.43.88.3 with SMTP id ay3mr9919389icc.61.1373467916157; Wed,
 10 Jul 2013 07:51:56 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Wed, 10 Jul 2013 07:51:15 -0700 (PDT)
In-Reply-To: <20130710114546.GF21963@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230056>

Jeff King wrote:
> +If `--batch` or `--batch-check` is given, `cat-file` will read objects
> +from stdin, one per line, and print information about them.
> +
> +You can specify the information shown for each object by using a custom
> +`<format>`. The `<format>` is copied literally to stdout for each
> +object, with placeholders of the form `%(atom)` expanded, followed by a
> +newline. The available atoms are:
> +
> +If no format is specified, the default format is `%(objectname)
> +%(objecttype) %(objectsize)`.
> +
> +If `--batch` is specified, the object information is followed by the
> +object contents (consisting of `%(objectsize)` bytes), followed by a
> +newline.

I find this slightly hideous, and would have expected an
%(objectcontents) or similar.

Perhaps --batch-check should become a non-configurable alias for
--batch="%(objectname) %(objecttype) %(objectsize)", and let --batch
default to the format "%(objectname) %(objecttype) %(objectsize)
%(objectcontents)".

I'm frankly okay with not having --pretty, and making the output in
the non-batch mode non-configurable (does anyone care?).
