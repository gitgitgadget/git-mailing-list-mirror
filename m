From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Make the git codebase thread-safe
Date: Sat, 15 Feb 2014 07:45:45 +0700
Message-ID: <CACsJy8Dzj5iyaUseNyU76ojG1C0VYR=v7xsc=6TSGxTh=Xh3Ag@mail.gmail.com>
References: <CA+TurHgyUK5sfCKrK+3xY8AeOg0t66vEvFxX=JiA9wXww7eZXQ@mail.gmail.com>
 <CABPQNSZ_LLg5i+mpwUj7pzXVQMY1tcXz2gJ+PWG-mP1iyjxoaw@mail.gmail.com>
 <CAHOQ7J8QxfvtrS2KdgzUPvkDzJ1Od0CMvdWxrF_bNacVRYOa5Q@mail.gmail.com>
 <CABPQNSZtQd51gQY7oK8B-BbpNEhxR-onQtiXSfW9sv1t2YW_nw@mail.gmail.com>
 <CAHOQ7J_Jrj1NJ_tZaCioskQU_xGR2FQPt8=JrWpR6rfs=c847w@mail.gmail.com>
 <CABPQNSYVGc9m0_xfAWe=3b7CXyGZ-2FfTMRbTJ=UECeZUtdgmg@mail.gmail.com>
 <52FBC9E5.6010609@gmail.com> <loom.20140213T193220-631@post.gmane.org>
 <52FD4C84.7060209@gmail.com> <CAHOQ7J8syoQLGwwkwPEX3wZir8sWDQ+k8sgHAKn=n_-Q_S8ipA@mail.gmail.com>
 <CAAErz9hzeiJ9f9tJ+Z-kOHvrPqgcZrpvrpBpa_tMjnKm4YWSXA@mail.gmail.com>
 <52FE68C9.3060403@gmail.com> <CAAErz9g7ND1htfk=yxRJJLbSEgBi4EV_AHC9uDRptugGWFWcXw@mail.gmail.com>
 <CAAErz9j=_FpWLSyUk43pp8A6e7Ej0crT8ghW5-yxBEbGkd6O+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Karsten Blees <karsten.blees@gmail.com>,
	Stefan Zager <szager@google.com>,
	Git Mailing List <git@vger.kernel.org>
To: Zachary Turner <zturner@chromium.org>
X-From: git-owner@vger.kernel.org Sat Feb 15 01:46:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WETOf-0001kc-QK
	for gcvg-git-2@plane.gmane.org; Sat, 15 Feb 2014 01:46:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753104AbaBOAqR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Feb 2014 19:46:17 -0500
Received: from mail-qc0-f177.google.com ([209.85.216.177]:43104 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752954AbaBOAqQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Feb 2014 19:46:16 -0500
Received: by mail-qc0-f177.google.com with SMTP id i8so20911072qcq.22
        for <git@vger.kernel.org>; Fri, 14 Feb 2014 16:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=zhX4G8TGNY7WV1vM0n6BqZ9kUiRgUJDmDfd3UqxVjWA=;
        b=wY3ltKtTQCHkRolGvC8P3xhDNsbacfVMhp6lhAfP6UqI/Ti0IqEoRlqfUlFsdcctZS
         lgUvg8HhhlW5I6C/8AD3Ensf/PphfqO7Dn2k2GvyxY+m3OBnzrUONWy5Q9q+CDT97QtG
         2TGrrUGJIMW1voeoQ7fDf1N8mdMZjQdbAHdvXZzkQFkiBGVeHU0vZzh13pFZ62+A/5Nb
         xWoorl5tuPZUFe2235Jo85YB3ePcZROnfskgbFzcWPPCi1teVx3GP+eUdM/uOYSkIrDl
         MnuA08YPl/T0J9kkPXtYWK4zD9ao13Bh5JZm8Q9U2ko4m2RHG3H3trywkbqrY6fewl2e
         AAGA==
X-Received: by 10.224.136.195 with SMTP id s3mr18482297qat.95.1392425176060;
 Fri, 14 Feb 2014 16:46:16 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Fri, 14 Feb 2014 16:45:45 -0800 (PST)
In-Reply-To: <CAAErz9j=_FpWLSyUk43pp8A6e7Ej0crT8ghW5-yxBEbGkd6O+A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242166>

On Sat, Feb 15, 2014 at 2:16 AM, Zachary Turner <zturner@chromium.org> wrote:
> (Gah, sorry if you're receiving multiple emails to your personal
> addresses, I need to get used to manually setting Plain-text mode
> every time I send a message).
>
> For the mixed read, we wouldn't be looking for another caller of
> pread() (since it doesn't care what the file pointer is), but instead
> a caller of read() or lseek() (since those do depend on the current
> file pointer).  In index-pack.c, I see two possible culprits:
>
> 1) A call to xread() from inside fill()
> 2) A call to lseek in parse_pack_objects()
>
> Do you think these could be related?  If so, maybe that opens up some
> other solutions?

For index-pack alone, what's wrong with open one file handle per thread?
-- 
Duy
