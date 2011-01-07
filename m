From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] git-cvs*: Make building (and testing) of CVS interface
 scripts optionally selectable
Date: Fri, 7 Jan 2011 16:01:48 -0600
Message-ID: <20110107220147.GB9194@burratino>
References: <1294433290-9262-1-git-send-email-robbat2@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Fri Jan 07 23:02:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbKNt-0000aD-4r
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 23:02:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755627Ab1AGWCF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 17:02:05 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:35136 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755623Ab1AGWCE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 17:02:04 -0500
Received: by vws16 with SMTP id 16so7300350vws.19
        for <git@vger.kernel.org>; Fri, 07 Jan 2011 14:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Ssejy52RLe5nS37M+w/csn01BZ10sfIW19zv49t7/Po=;
        b=p/OY+nDYcBuXuRklw37rWOoTrxldEEHSEBAvtfv4AJMeFb1NF9E3uilmCMRpWsbsyn
         q9BJUc2dpCt338LxVe4RsNPtODBA0S5bvGzD9CBgMp5QZd4ZhQlfnespQReJNcMTnKcW
         BTegPe8Uwyz9q0vYsF1Y3H55vOAo4GSYxYkWQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ID8+6kWAyJTsHIG9hb1qE168FMedLeYPO3BPLlkcFLVCFBm48fE3nBPZASp3wowJQt
         055cD8U1j9YuUukwJOuhFWHY2t/m7oFgoL+gnp1R7aYNKB/3hx+v0Qa/E4fnB6vJXXnb
         LgMouJlkhgI3QdsXA11xYWP9BpbFJjGq9QN+Q=
Received: by 10.220.179.7 with SMTP id bo7mr233701vcb.105.1294437723896;
        Fri, 07 Jan 2011 14:02:03 -0800 (PST)
Received: from burratino (adsl-69-209-72-219.dsl.chcgil.ameritech.net [69.209.72.219])
        by mx.google.com with ESMTPS id b26sm9994673vby.13.2011.01.07.14.02.01
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 07 Jan 2011 14:02:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1294433290-9262-1-git-send-email-robbat2@gentoo.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164770>

Robin H. Johnson wrote:

> Presently, the CVS interface scripts are always built, and their
> test-suites run based on a binary named 'cvs' happening to return zero.
> If there something other than the real CVS there, bad things happened
> during the test-suite run.

This explanation seems quite odd to me.  Are you saying we can't rely
on the 'cvs' name being "taken" and should live in fear that someone
will implement an incompatible utility with the same name?  Did that
actually happen?

I would find it easier to believe

	Building and testing git's cvs support is slow, because ...

	So give users with no interest in cvs interoperability a way
	out.  By defining NO_CVS you can avoid this time-consuming
	piece of the build process.

Or for a different patch:

	Add a NO_CVS knob so users with no interest in cvs support
	can avoid polluting their $(libexecdir) with unwanted entries.

Or:

	Introduce a new NO_CVS knob.  If set, the CVS interop scripts
	will be replaced by unimplemented.sh so sysadmins and
	distributors can hopefully get a nice, clear error report instead
	of confusion when users try to run them with cvs not installed.
