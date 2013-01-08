From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] git clone depth of 0 not possible.
Date: Tue, 8 Jan 2013 14:33:40 +0700
Message-ID: <CACsJy8B0ftDDagTpO4wh-LsBOBy+BhwhV=H-68U246Lq4=Ssfw@mail.gmail.com>
References: <1357581996-17505-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: schlotter@users.sourceforge.net, gitster@pobox.com,
	Ralf.Wildenhues@gmx.de, git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Jan 08 08:34:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsThf-0006Hm-Jm
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 08:34:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752172Ab3AHHeM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 02:34:12 -0500
Received: from mail-oa0-f45.google.com ([209.85.219.45]:38680 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093Ab3AHHeL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 02:34:11 -0500
Received: by mail-oa0-f45.google.com with SMTP id i18so80598oag.4
        for <git@vger.kernel.org>; Mon, 07 Jan 2013 23:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=xfaP1X2FSQQZ3l4u3r99jqAQ64ebDKIUf9zfvxizHCA=;
        b=fKGIdz/wpY1HiOlYNd2USshl/CdEXAudo83lyy8+wXZHW5Oyifvl1bEASjdmQtWMaQ
         LOqm2Qwxam0Emg8KAnRR2eQch3VO+B5GJCKDj/Oz4nKmc1Oi2bD8gKgeWXIwBf40u2Pp
         aZbABlHhSB5jJ3BhEpu/+heemxSclpFRVbhAAja6IvbYm03V8qYiQ/syWOIZpfWXLDqT
         c+TwyHDgwp2BCTE8iudg9VNtbTVqrus89lzqjerdGZK+exkvknP/JmDYb4vF/SoPmhvH
         cwg7kGTXTNjjvhEVwI0rK3WoBZwysEP8OUMKXrW72EWmce3BZTWSKbWSUBgkeefZ2Vqe
         ZHTA==
Received: by 10.60.22.164 with SMTP id e4mr35075541oef.87.1357630450950; Mon,
 07 Jan 2013 23:34:10 -0800 (PST)
Received: by 10.182.153.69 with HTTP; Mon, 7 Jan 2013 23:33:40 -0800 (PST)
In-Reply-To: <1357581996-17505-1-git-send-email-stefanbeller@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212939>

On Tue, Jan 8, 2013 at 1:06 AM, Stefan Beller
<stefanbeller@googlemail.com> wrote:
> Currently it is not possible to have a shallow depth of
> just 0, i.e. only one commit in that repository after cloning.
> The minimum number of commits is 2, caused by depth=1.
>
> I had no good idea how to add this behavior to git clone as
> the depth variable in git_transport_options struct (file transport.h)
> uses value 0 for another meaning, so it would have need changes at
> all places, where the transport options depth is being used
> (e.g. fetch)
>
> So I documented the current behavior, see attached patch.

If we choose not to do the off-by-one topic Junio suggested elsewhere
in the same thread, I think this document patch should be turned into
code instead. Just reject --depth=0 with an explanation. Users who are
hit by this will be caught without the need to read through the
document.
-- 
Duy
