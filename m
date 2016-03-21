From: Thomas Adam <thomas.adam22@gmail.com>
Subject: Re: When does git check for branch-X being uptodate with origin/branch-X?
Date: Mon, 21 Mar 2016 20:43:17 +0000
Message-ID: <CA+39Oz4Atuv3N0QNj8o1SYgHzMUyES1QHUsWh-MdNiNr-xPM_w@mail.gmail.com>
References: <CA+39Oz4izkhtxbUH8cQoD5-DLKAtv9KnC9OkG_ZhFw6Ysg0+gw@mail.gmail.com>
 <20160321202810.GD32071@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 21 21:43:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ai6fq-00045O-Ek
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 21:43:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754801AbcCUUne (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 16:43:34 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37171 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754522AbcCUUnd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 16:43:33 -0400
Received: by mail-wm0-f41.google.com with SMTP id p65so137406676wmp.0
        for <git@vger.kernel.org>; Mon, 21 Mar 2016 13:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=guLzNT2IquMn73KK1Dw1ESHkrvyJfrYIY9tAqGD4f0E=;
        b=MM3W5/VgN8bs9LOUuO4bK7meq+chnaArcAd4X1PDm893DEFpqvkXlxENwLCCb0KHdc
         13hKeJwWekS/Mz9v3g9nAiKnTFRLcyYgmuILEX/c7OZ7rxRtfcOqar3uzN7vuW9HyC8L
         rBiWS04uTdbss7bBe4eS3jLKfNdbE1Ux0Ha4coWiYN99cmKNGswyMxchwdH7odxLcjLC
         zjVV9ZfEc2jvHYDxRBOzmfp7S5Z0uHF7VxeZJU7cb32uKbWfQk9mJKesR9wo8NF4fdRg
         ksRk1yBRZalgti0rEqYexvsgKUyz5c+USoHiShhtTJsTelVxazgCg4sc1Yj6BE8VJnU2
         KpZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=guLzNT2IquMn73KK1Dw1ESHkrvyJfrYIY9tAqGD4f0E=;
        b=EvW8nheDUm6Weu+o5g/FsLuAagUuwvsRSZ1Sldow5isN5JQe2nAolON1MJ6Uc69wWF
         xHow+Jn0gXsdBUeiyZuKWvNlBpEjJd1Y/xNU2yEiSs7/W0IeDp6llnRrzgOgtyE3Ng72
         dIzcQnJhSRBs2UHvnIpbF22TFcY8I56rgbeMmYs4k1BZVO7NE1p4EJLEcL2wKFKbLY16
         zyjN7+4T6erbLxHyEXoCFm62eKGwDEbYyUYup+xygH3123m+5L+urtbaAnO6/dWtB9kz
         2EViKQsDmC1ansqaDTqnfT5cWwnbI0Up6CWcMIFHHYPWHNP6n2U8cr4WyFPIoAYlVtvy
         JRKA==
X-Gm-Message-State: AD7BkJLOkZ2hsLjnRoiMeVGdlMjwaVuHlCaRzD5mXMrVSV/FKXKAL9qbZlAC5vbilEXUBnlKLA2mqx33vKefsA==
X-Received: by 10.194.187.240 with SMTP id fv16mr36917901wjc.53.1458593012021;
 Mon, 21 Mar 2016 13:43:32 -0700 (PDT)
Received: by 10.194.110.168 with HTTP; Mon, 21 Mar 2016 13:43:17 -0700 (PDT)
In-Reply-To: <20160321202810.GD32071@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289456>

On 21 March 2016 at 20:28, Jeff King <peff@peff.net> wrote:
> We never contact other repositories unless explicitly asked to by
> fetch, pull, push, etc. If you want to have the most up-to-date value
> without merging, you can just "git fetch" to update the tracking
> branches.

Thanks.  I understand how to use git-fetch, it's more a case of
whether even printing that message is useful?  I appreciate it can
only go on the cached value, but it is still misleading to print that
in the case where the cache might not be up to date.  Of course,
determining that is a different problem.

-- Thomas Adam
