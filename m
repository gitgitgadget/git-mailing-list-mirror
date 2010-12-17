From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Performance issue exposed by git-filter-branch
Date: Fri, 17 Dec 2010 20:01:41 +0700
Message-ID: <AANLkTi=eWaaGKGpUptdkVg5iEMiZK5FQ9URjUTgd+LxB@mail.gmail.com>
References: <41C1B4AC-8427-4D62-BEB6-689A4BE4EE5B@irridia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Ken Brownfield <krb@irridia.com>
X-From: git-owner@vger.kernel.org Fri Dec 17 14:02:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTZwv-00037L-O8
	for gcvg-git-2@lo.gmane.org; Fri, 17 Dec 2010 14:02:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754051Ab0LQNCN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Dec 2010 08:02:13 -0500
Received: from mail-ww0-f42.google.com ([74.125.82.42]:57989 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751359Ab0LQNCM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Dec 2010 08:02:12 -0500
Received: by wwi17 with SMTP id 17so465691wwi.1
        for <git@vger.kernel.org>; Fri, 17 Dec 2010 05:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=TI9pvaDACyeVoFVNXjlmfHsJuSFg0fnxBezjzF25GkE=;
        b=rnKsy769we+Hnu489nTeNl01IcRLo4WELE8vm4N5gkZ8njh9w4RuJAiu6z2n0pOlHg
         8vwPRJuTkgOdJ/cPRajn8LI2VitqQVrDImKOOwMfCr+SlXIVqc6b0eWtJOhhgtjWW2Wl
         slwFVxzRrE7B21jEAnPJmG9eIiyHwQ+4auN/E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=ZUm9sxDeS4xKKkn4voenE70eexsr8z3aKKFV4mR/QVFKpyDTZmHWtFpXkK4sR4hOd5
         8C2RMftAn5hFEFbJfySF2H6fh/xv2DCdBOV3brEgNh36Dz0X80VbYneONnv7SE9fm26G
         8Vo157AcEzYBeI1dn0NRt/Kqd+eb5yZ1AsXqE=
Received: by 10.216.162.70 with SMTP id x48mr3841207wek.4.1292590931203; Fri,
 17 Dec 2010 05:02:11 -0800 (PST)
Received: by 10.216.158.83 with HTTP; Fri, 17 Dec 2010 05:01:41 -0800 (PST)
In-Reply-To: <41C1B4AC-8427-4D62-BEB6-689A4BE4EE5B@irridia.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163878>

On Fri, Dec 17, 2010 at 8:07 AM, Ken Brownfield <krb@irridia.com> wrote:
> cache_name_compare (and the presumed follow-ons of memcpy/sha/malloc/etc) is the major consumer.

Other people have given you alternative approaches. I'm just wondering
if we can improve something here. cache_name_compare() is essentially
memcmp() on two full paths. A tree-based index might help. How long
are your file names on average? Are your trees deep?
-- 
Duy
