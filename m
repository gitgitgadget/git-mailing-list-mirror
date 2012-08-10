From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Porting git to HP NonStop
Date: Fri, 10 Aug 2012 10:38:06 -0700
Message-ID: <CAJo=hJsz3ooDAV-0S-BDknnbQPK9ASEYw8b7t7PyKEtJ5jgxQA@mail.gmail.com>
References: <003a01cd7709$63725260$2a56f720$@schmitz-digital.de>
 <CAJo=hJvwih+aOMg6SKP94_1q-az1XV-1Pcf=_fGbvdDcDpC23A@mail.gmail.com> <004701cd771e$21b7cbb0$65276310$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, rsbecker@nexbridge.com
To: Joachim Schmitz <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Fri Aug 10 19:38:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SztAQ-0008JC-5J
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 19:38:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758308Ab2HJRi3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 13:38:29 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:63335 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753615Ab2HJRi1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 13:38:27 -0400
Received: by yenl14 with SMTP id l14so603803yen.19
        for <git@vger.kernel.org>; Fri, 10 Aug 2012 10:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=YU4BkByQz9i6zynGT125E+RtbCfcUo4OQRC7MTHNji0=;
        b=ZtFlI6satL7u9HM181t+a3+kNPVStWu+Wy4Yr+7dWVqXW4kGnbYYi9RsuLG6Kp+ePu
         dYgLFUWSgt97+YwpgvQ6NXQj5X6PTwnboI91KR3bFv6SrdQYEd2qHBdQyDyKeX47nXIm
         JQK517Z5rxDS1BOXFRq5TO4bsOmr+LgYYdjBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=YU4BkByQz9i6zynGT125E+RtbCfcUo4OQRC7MTHNji0=;
        b=j6B21WyvAlhgHSMmzIGQnkaUPmwkZnm6JbJ9dEdKVlry16MT1HFOAwWh9b0DK6tiFf
         LCyAGgr4tOsWMn+6XghBrc9RSI3ZYnHU19jqPa5TxnHv/mVVyc8TNTryMbZ5Tkqr1b9q
         UUIpdnYJhdYeQv15yGNULQZPcqiw2DqDibKaWRUjFrSti5lFmpLsiy6tTK8RDv+Eaz9B
         bl3n5vraxJ+MgyTCHBpd5yn22dcHsryHXck7mrXjMD6sQfMq0t61EhN5QtG9VHdeo04Y
         mEPXxzFbMPh5951zk53GvLxI2rFot9PHM2dZjtS/FBauyl89QVsGhZKycH1lAHvaYhRj
         9uOA==
Received: by 10.50.158.226 with SMTP id wx2mr2633760igb.18.1344620306904; Fri,
 10 Aug 2012 10:38:26 -0700 (PDT)
Received: by 10.64.22.231 with HTTP; Fri, 10 Aug 2012 10:38:06 -0700 (PDT)
In-Reply-To: <004701cd771e$21b7cbb0$65276310$@schmitz-digital.de>
X-Gm-Message-State: ALoCoQnc1Cyi1gwUx+hWzhiY0s/61ZWrKtzjEtU7bDzXBuyUFqJ6uRcoo0UzTawQMX+s6ljjG8xS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203238>

On Fri, Aug 10, 2012 at 10:32 AM, Joachim Schmitz
<jojo@schmitz-digital.de> wrote:
>> then use `git init --bare` in a new directory to copy in the templates,
> and see if
>> its the template copying code that is making an incorrect copy.
>
> "git init --bare" gives the same error. It isn't copying any of the
> subdirectories, only the file 'description'

Time to start debugging copy_templates_1 in builtin/init-db.c. :-(
