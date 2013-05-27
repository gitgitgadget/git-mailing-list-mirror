From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: git-send-email doesn't deal with quoted names
Date: Tue, 28 May 2013 01:40:20 +0200
Message-ID: <CAHmME9p19eysjEVk+6FmAb2FQb7dq_e3k_KLQLRZqhx2Bs6O3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 28 01:40:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uh71k-0007fz-RI
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 01:40:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758063Ab3E0XkX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 May 2013 19:40:23 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:56341 "EHLO frisell.zx2c4.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756209Ab3E0XkW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 May 2013 19:40:22 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
	:date:message-id:subject:from:to:content-type; s=mail; bh=UquBt+
	yf470rNDlfnuoVcWKDnbc=; b=V81qRfIIN+awuvDtS/zxiLnk7bXG532xfQn3UW
	DnXe0LtPcSdw6Z3j+lqvPt8dqJNYUX1go4ib4qX4jfGFfl6K9PpdrquhbXmjx6fV
	zFdrdl+HKCnUusyifiRfG2LD/jmUFGiQid+lQzWCFa4rnZYetKsPo6+LSxt+FN1H
	51UJ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=zx2c4.com; h=mime-version
	:date:message-id:subject:from:to:content-type; q=dns; s=mail; b=
	LCymWvs28HPZKZWVcEkupwrMyAqZwZkrv8Eqi50EKS5Jq/W/U3xKFydyq8YQxjTp
	8TksZmCKf4daZdP2y08bgmrJJhqAJ73Ief8mKRZ2tevSX9yNWnJGzAAyugEFdwib
	rDjn7TPEl9rHdWjcP70daD2xhp6ARLJITd17MnQAyko=
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ea1d710f;
	TLS version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO;
	for <git@vger.kernel.org>;
	Mon, 27 May 2013 23:40:20 +0000 (UTC)
Received: by mail-vc0-f175.google.com with SMTP id hv10so5060924vcb.34
        for <git@vger.kernel.org>; Mon, 27 May 2013 16:40:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=kavD5bAfhbpiYU/5+qhzWr5naTxbj0qIA7HCchK0nHw=;
        b=Ytv8EHZbZwAoQkuPxINaIHJOyIVTWmiR92bKjhe1USA7gFwlMfMDdhiTFJjN5ZBeUy
         KvA81CVpsw/XTh3vWOgX/hHpGzkhHQIDvqauDzkt9loeNOSLAgedbE0t703NNNfwDfVi
         SS/hzUgE5Ir2aKbqYR92idfbwTI9i5cu1pWIQmzCRaeop1he2FcGHG4hzHsFPBBYqzef
         OPtmF7vSVzBp85BM0aVfqk4iuokfGZiZhWQcMZE2wsBIaheCQsW83s80zgmlQIZ6wp62
         GvJTOeTIBeQBm7NqILPKhp/ojCOVNCS0q1kUsPpXddfRwkO5SEH6ERedXapFxambyYxF
         /Qtg==
X-Received: by 10.220.76.137 with SMTP id c9mr562616vck.48.1369698020190; Mon,
 27 May 2013 16:40:20 -0700 (PDT)
Received: by 10.52.232.4 with HTTP; Mon, 27 May 2013 16:40:20 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225616>

Hi,

My commit author name is "Jason A. Donenfeld". Because this has a dot,
SMTP handling likes to put it in quotes.

git-send-email has this line:
            if (defined $author and $author ne $sender) {

With my name, this always winds up false, because it's comparing
'"Jason A. Donenfeld" <Jason@zx2c4.com>' with 'Jason A. Donenfeld
<Jason@zx2c4.com>'.

So, the logic needs to be fixed somehow.

Thanks,
Jason
