From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH/RFC/GSoC 16/17] editor: implement git_sequence_editor()
 and launch_sequence_editor()
Date: Wed, 16 Mar 2016 21:06:09 +0800
Message-ID: <CACRoPnRMOp38vfkQZjmkUqr+urN8NYcNN_oNzHtJqfyTorr1ug@mail.gmail.com>
References: <1457779597-6918-1-git-send-email-pyokagan@gmail.com>
	<1457779597-6918-17-git-send-email-pyokagan@gmail.com>
	<alpine.DEB.2.20.1603150755450.4690@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Sam Halliday <sam.halliday@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 16 14:06:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agB9f-0006lw-HJ
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 14:06:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935037AbcCPNGS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 09:06:18 -0400
Received: from mail-lf0-f43.google.com ([209.85.215.43]:34668 "EHLO
	mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933997AbcCPNGL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 09:06:11 -0400
Received: by mail-lf0-f43.google.com with SMTP id e138so17997008lfe.1
        for <git@vger.kernel.org>; Wed, 16 Mar 2016 06:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=KBAMYQvW+aGZc7E15R/vpk7OxB69u7fJV8Yrd8M3Qqs=;
        b=ZG/SXatmFWx68z8TRVnBwICSaIxG17PLulNJSj56kaPUvEV9W1eBWsGT3AFBDk91Eh
         qUBG+lgFsmrEgbFHHY59+z8fN+NkvYhFN/iqptn84wnisTOha6XYtxEFOcizktPVdHhh
         ka4Nb8sknZtCXKBSlKry2iI64qxw1U/dKXQaRHtxivj460OW29lFJ5hIE0gc98HkNsIy
         nln4DW+lp5accHiS6JDMXnlCjJDsMS4BSyjAvRTx4BKsbm/8u+ViAVnFBen/Etmh7kxT
         nUubqV/iu9ij4KFl3nksRcT8q2HFRnhJZIjIlD5WP4L+k+Y3IMV+ED44i1Gxc/bV7QsO
         qOew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=KBAMYQvW+aGZc7E15R/vpk7OxB69u7fJV8Yrd8M3Qqs=;
        b=Z0unFFQMNKVBSn4LTAJVWOYvkLeeo6+5vnQtI9g2CleqJ4gqZGiQN3/b4xCqUpuo/V
         93dVuPh3zlmqlQ0YsdmuRUvzAZZOXxGI+fqjDkoKi9JXpGq+OKR8oJEZWwLT2aCL6TVj
         /ToQRgHWI4/rIy+9lGVVu7AW5Ei7PpkxUWNYeE13XyVb5cQO27JvX0QOnUy/B3DnMmLD
         w5WiPu+eSQzigNCtab1xtZtsEQLLj/8sCPDwlEpHqqlHeKqdfZLAXePfOoKv5m4+E/rq
         opFxhxYFAxL30vW7udDN4jqc+LkEsILVE+HgvGph0hOeYYUgBjZTzSCWv1MCe12a4D2D
         Nowg==
X-Gm-Message-State: AD7BkJL+OnaGTvdQoVEYama+ey3ihrJevm6Bkyx+23vM83F0x2m1ZAeOAoA9q/jhjjTofgshjlRxjE7CEmOlAQ==
X-Received: by 10.25.85.145 with SMTP id j139mr1375604lfb.131.1458133569244;
 Wed, 16 Mar 2016 06:06:09 -0700 (PDT)
Received: by 10.112.207.74 with HTTP; Wed, 16 Mar 2016 06:06:09 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1603150755450.4690@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288969>

Hi Dscho,

On Tue, Mar 15, 2016 at 3:00 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Sat, 12 Mar 2016, Paul Tan wrote:
>> ---
>>  cache.h  |  1 +
>
> No need to clutter cache.h with a function that is only to be used by the
> sequencer. IOW let's make this static in sequencer.c.

The function needs to be implemented in editor.c because it would be
better for it to share the same code that launch_editor() uses
(implemented in this patch by splitting the logic into a static
function launch_specific_editor())

We could move the declaration to sequencer.h though.

> I would also prefer pairing this short function with the change that
> actually uses it (in my topic branches, I like to compile with -Werror,
> which would result in a failure due to an unused function), in the same
> patch.

Sure.

Regards,
Paul
