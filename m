From: Kevin Brodsky <corax26@gmail.com>
Subject: Duplicate -s entry in git-format-patch(1)
Date: Fri, 25 Mar 2016 11:45:56 +0000
Message-ID: <56F524F4.3000409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 25 12:46:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajQBo-0000s5-8k
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 12:46:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751989AbcCYLqB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 07:46:01 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:32977 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751399AbcCYLqA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 07:46:00 -0400
Received: by mail-wm0-f45.google.com with SMTP id l68so23073222wml.0
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 04:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=ZPRjiPJ0gyVnzgym/i7MN3HXmc9ZD7XHGjF5/5eIy5o=;
        b=VqcBg6Pc3JSdu244DVUgXm7ZM8ZHrFXTiL5Ib1ZKrsbGWyGrgEUK1mrgO65yuEpoez
         PYwM23tsoCOP85blqMqEYKRfQF4oQO9agb1P/AeIA1HH39VC9mlz5Tc08XdjtkMGe1JA
         XhyWWxIIyBwtb/q2PoCNl050RKEJfegjEvldOmmVNvNtEayhQ9lzk7nWTlYfktysYnnX
         /0ugsvmueA55KRXxBi9DptAeaP4KoEBlbXn6B/9JCYUkuMgQtBiMShp/E0Tg4ydJ+9vW
         YcfTYVi5dC/0QLRtHgMiDkTFKZfbpoONHU0y1bTVhNkrxkpcEARO8FMDluYk38LzT8sw
         igTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=ZPRjiPJ0gyVnzgym/i7MN3HXmc9ZD7XHGjF5/5eIy5o=;
        b=XAtdBgUL8pvEh9iHL+lOs4bJp3Q7db2uDg0Oi2WoTRlosFn7eO7sMkFm5eNirmzuZD
         d+alOtlv5AdK00JE4rhQht0qWik2hvNvpf0ocdOYwEXLGSpC2RF+cjFBg9EZx4RPjVLt
         uZtMRu04ohYPEv3UIq4CiX+Vur2Ejqe7jjki3lf+Znv0uXEAE1PV9QX+7ylD3E05sqxn
         ts7DhrutO6qC4KU1KVi+Td/XD0CedMWmDEJR75QsevHWFZVt2xVW9rbm3tGU9Nf5g4u7
         a8P95xSQeQDL5EP5sgIzMgDd2534FdovAGeBQinPREAcV0oEP5sKEIwpWOQpiYFlhHqY
         zL7Q==
X-Gm-Message-State: AD7BkJI61RVfVXf9YlHy/fMxiMMgUiCcUIRTwySOD4w3H6CIYI3Y3eLf62XKpu7PZWQCYw==
X-Received: by 10.194.121.194 with SMTP id lm2mr14531704wjb.71.1458906358296;
        Fri, 25 Mar 2016 04:45:58 -0700 (PDT)
Received: from [192.168.0.10] (61.42.99.195.dyn.plus.net. [195.99.42.61])
        by smtp.googlemail.com with ESMTPSA id fv6sm11654402wjc.12.2016.03.25.04.45.57
        for <git@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 25 Mar 2016 04:45:57 -0700 (PDT)
X-Google-Original-From: Kevin Brodsky <corax.2.6@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289881>

Hi all,

I've noticed for some time now that the man page for git-format-patch is
quite confusing because it includes two entries for the -s option:
- "-s, --no-patch", which is pulled by "include::diff-options.txt[]"in
Documentation/git-format-patch.txt
- "-s, --signoff", which is directly part of git-format-patch.txt.

The first entry is apparently wrong, format-patch never interprets it
this way, as far as I can tell. This is particularly problematic since
it's the first one listed in the man page...

I don't know how to fix this issue without duplicating diff-options.txt,
hopefully someone will be more inspired than me ;)

Thanks,
Kevin
