From: John Gallagher <johnkgallagher@gmail.com>
Subject: `git describe` in an export-subst format string?
Date: Sun, 28 Apr 2013 14:02:04 -0400
Message-ID: <CAFoDJR8RQExLwXcrViAJpWgvq+wBopY-Wq1keHxVqB3QwtAz4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 28 20:02:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWVvP-0001cU-FX
	for gcvg-git-2@plane.gmane.org; Sun, 28 Apr 2013 20:02:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754970Ab3D1SCG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Apr 2013 14:02:06 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:53206 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753958Ab3D1SCF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Apr 2013 14:02:05 -0400
Received: by mail-ie0-f176.google.com with SMTP id x14so6430530ief.7
        for <git@vger.kernel.org>; Sun, 28 Apr 2013 11:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type;
        bh=AD2orvQ412EKwuonPGQUYbA1ISyz6prniZR5+4lqChw=;
        b=N/+vxPSpfx/eSKr8I/0hMuH+J2JF8TJ+cj9fD7QVSOc1uRVOpj7oI0DfTimDkkB/73
         YI3xx5+DT3bL/yr8e9cpVUs6IUD4tfvPeTJJ6ErHmiD8HeqL1c+8MLB2SVRH3TTLg3Uu
         PnGqkPlwbsZqJzSr08guZ8dRYZIuTfG5ImdEuq74yKmoYwc+drrCm5IFqcRkp4tFOmmM
         QTu58XB7yRR0mJQI3XOLwBbMH80H9BiC5bXnNjZYpEkGxWDvrDzZdSc5+7reOqEaLhzF
         /5CGHB9Cu1kPpVKeNnkxuL/dRAttAg+585Z3Ua2JLHD4mI7cgnzURVyGbvqfBnruvN3K
         JeQQ==
X-Received: by 10.50.7.42 with SMTP id g10mr28068iga.97.1367172124534; Sun, 28
 Apr 2013 11:02:04 -0700 (PDT)
Received: by 10.64.48.168 with HTTP; Sun, 28 Apr 2013 11:02:04 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222737>

I originally posted this as a question about getting `git log` to
output the same thing that `git describe` does to the git-users
mailing list, and was directed here. The actual thing I want to do is
something like this:

  static const char *project_version = "$Format:...$";

where "..." is something that `git archive` will replace with the
output of `git describe`, given the file has the export-subst
property, possibly with arguments to git describe (--tags, --all,
etc.). In a normal build I can do this with the build system just
calling git directly, but if I'm archiving a tarball off there doesn't
seem to be a way to do this (other than manually replacing the format
string myself as some secondary step).

Does this seem like a reasonable thing to do, or am I overlooking a
better alternative? If this is something that seems reasonable, I
wouldn't mind taking a stab at implementing it. If that sounds okay,
could make sure I'm pointed in the right direction? E.g., should `git
log --format=...` have options that spit out `git describe` strings
since that's what export-subst currently uses, or should there be a
separate $Format:...$ option that runs git describe?

Thanks,
John
