From: =?UTF-8?Q?Jean-No=c3=abl_Avila?= <avila.jn@gmail.com>
Subject: [BUG] can not escape sharps in git config file
Date: Tue, 24 May 2016 12:14:42 +0200
Message-ID: <57442992.6030306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 24 12:14:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b59MQ-0006G7-LQ
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 12:14:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754681AbcEXKOr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 May 2016 06:14:47 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37426 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753093AbcEXKOq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 06:14:46 -0400
Received: by mail-wm0-f50.google.com with SMTP id z87so17525175wmh.0
        for <git@vger.kernel.org>; Tue, 24 May 2016 03:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=gEHG+uZX5bdqne95LJjHzceLlvdxbfCTzmIz58agz/s=;
        b=ljj7qmfDKMOvQIg/okN8IobNaTNahHlmbCxxoYu+ao8vph/eY0AylD+SPKD8bRI3uM
         smAFVmZPzhcvpuGocnIwbk1A+gLY2/fOX9+TUuEqXDrURwOI/kIyWOmmRSZpmFDb5Qoc
         /L6Dkx8Iu+QLHVZRSOV8/2AYBmm4fBn6koyB4Cu5jnCDT1mMUeMdUdyJ52+CtB0ZZF35
         dlxROt3lwB9M4ZLM3/FztfQZUFxm55KSo5Mu31265aG44Ofz/pyzn0FOLTFkC1nRKAay
         +QUDmsWSG6x0bmJptc4nTX8pMGdNyLhKgK442P59CYv6mdjk5ZY4JrdFvRt8A3kYLclr
         qNCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=gEHG+uZX5bdqne95LJjHzceLlvdxbfCTzmIz58agz/s=;
        b=JjLQ5+ioHE0kXDOVGdWoH4Kt0aYc15sJ6HzVwHum423mL9I2sCvBwsQWIjyGhnA8KE
         LVEwC5R1IA6vYdpUsiWWZceCIjoBKucHBMEU309QCEdsyaM1RYnNcoyquAkUqFJ5j9Wd
         hjSC0nEeP0DgRw9JryrfcTG08La250OCq4+sUVRaNVgkLBG4Zo731JkeIQwInSXUDpCb
         KE7yEM1SSBPBFn7QVTK2WPC23uIGqCgXt62i8cUQeqlh4v/2Vkq/Tm215H40AzKxkIUQ
         LkVqN4hJet6KgYvDsJjBPT0YHG/xNG8wx86002s1IKxziEYwHRmWxQ/c9f4gwpIHkaQy
         cUdQ==
X-Gm-Message-State: ALyK8tKci+9uGPvQHtj+/P9kjRgBx7tx/o3Fi+sbDb12pwbpgnqIAfSF1OVjRZ6yRTmAbQ==
X-Received: by 10.194.173.42 with SMTP id bh10mr3963618wjc.150.1464084884731;
        Tue, 24 May 2016 03:14:44 -0700 (PDT)
Received: from [192.168.1.75] (static-csq-cds-097114.business.bouyguestelecom.com. [164.177.97.114])
        by smtp.googlemail.com with ESMTPSA id m3sm2361102wjc.27.2016.05.24.03.14.43
        for <git@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 May 2016 03:14:43 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295482>

Hi everyone,

I stumbled on this:

config file:

[filter "kicad_sch"]
        clean =3D sed -E 's/#(PWR|FLG)[0-9]+/#\1?/'
        smudge =3D cat


Then in the shell:

=C2=B1 git add -u
sed -E 's/: 1: sed -E 's/: Syntax error: Unterminated quoted string
error: external filter sed -E 's/ failed 2
error: external filter sed -E 's/ failed

It seems that the  # is used for end-of-line comments and can not be
escaped, even in quotes or backslash.

JN
