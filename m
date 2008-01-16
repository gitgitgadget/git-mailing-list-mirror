From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Git Cygwin - unable to create any repository - help!
Date: Thu, 17 Jan 2008 00:45:27 +0100
Message-ID: <20080116234527.GA3499@steel.home>
References: <20080114202932.GA25130@steel.home> <20080115200437.GB3213@steel.home> <a5eb9c330801151212y30cf4f63r9c294ba33da2b8f@mail.gmail.com> <200801160002.51048.robin.rosenberg.lists@dewire.com> <20080116071832.GA2896@steel.home> <a5eb9c330801160742j645ee50p72ee0a93adf8f94f@mail.gmail.com> <20080116183124.GA3181@steel.home> <a5eb9c330801161048x4b5a88dcsebd7cf9754f72ba6@mail.gmail.com> <20080116191737.GD3181@steel.home> <a5eb9c330801161344i1da447c7sb447bf6274d408e8@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Paul Umbers <paul.umbers@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 00:46:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFHxI-0006Ch-Qv
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 00:46:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbYAPXpb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 18:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750898AbYAPXpb
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 18:45:31 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:32059 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750861AbYAPXpa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 18:45:30 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CculzyClFj/1U=
Received: from tigra.home (Fad79.f.strato-dslnet.de [195.4.173.121])
	by post.webmailer.de (klopstock mo35) (RZmta 15.4)
	with ESMTP id a05b7fk0GMvUcW ; Thu, 17 Jan 2008 00:45:28 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id D9E02277AE;
	Thu, 17 Jan 2008 00:45:27 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 51B5356D22; Thu, 17 Jan 2008 00:45:27 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <a5eb9c330801161344i1da447c7sb447bf6274d408e8@mail.gmail.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70776>

Paul Umbers, Wed, Jan 16, 2008 22:44:10 +0100:
> Here's the log from the latest strace.

Something is fishy here (aside from the horrible selection of
information in the trace output):

   56 1151793 [main] git 3244 symlink_info::check: 0 = symlink.check (c:\workspace\git\git-1.5.3\.git\objects\2e, 0x22BBE0) (0x2A)
   58 1151851 [main] git 3244 path_conv::check: this->path(c:\workspace\git\git-1.5.3\.git\objects\2e\d63d326ffdb2fd4b703780f4d61f1893cac63b), has_acls(1)
   65 1151916 [main] git 3244 fhandler_base::open: (c:\workspace\git\git-1.5.3\.git\objects\tmp_obj_rOxD3L, 0x110000)
  206 1152122 [main] git 3244 fhandler_base::set_flags: flags 0x110000, supplied_bin 0x10000
   76 1152198 [main] git 3244 fhandler_base::set_flags: O_TEXT/O_BINARY set in flags 0x10000
  308 1152506 [main] git 3244 fhandler_base::set_flags: filemode set to binary
  146 1152652 [main] git 3244 fhandler_base::open: 0 = NtCreateFile (0x6D0, 20100, c:\workspace\git\git-1.5.3\.git\objects\tmp_obj_rOxD3L, io, NULL, 0, 7, 1, 4400, NULL, 0)
   74 1152726 [main] git 3244 fhandler_base::open: 1 = fhandler_base::open (c:\workspace\git\git-1.5.3\.git\objects\tmp_obj_rOxD3L, 0x110000)
  105 1152831 [main] git 3244 fhandler_base::open_fs: 1 = fhandler_disk_file::open (c:\workspace\git\git-1.5.3\.git\objects\tmp_obj_rOxD3L, 0x10000)
 5915 1158746 [main] git 3244 fhandler_disk_file::link: CreateHardLinkA failed
   94 1158840 [main] git 3244 seterrno_from_win_error: /ext/build/netrel/src/cygwin-1.5.25-7/winsup/cygwin/fhandler_disk_file.cc:893 windows error 183
   72 1158912 [main] git 3244 geterrno_from_win_error: windows error 183 == errno 17
   64 1158976 [main] git 3244 __set_errno: void seterrno_from_win_error(const char*, int, DWORD):310 val 17
   65 1159041 [main] git 3244 fhandler_base::close: closing '/cygdrive/c/workspace/git/git-1.5.3/.git/objects/tmp_obj_rOxD3L' handle 0x6D0
  124 1159165 [main] git 3244 link: -1 = link (/cygdrive/c/workspace/git/git-1.5.3/.git/objects/tmp_obj_rOxD3L, /cygdrive/c/workspace/git/git-1.5.3/.git/objects/2e/d63d326ffdb2fd4b703780f4d61f1893cac63b)
   87 1159252 [main] git 3244 normalize_posix_path: src /cygdrive/c/workspace/git/git-1.5.3/.git/objects/tmp_obj_rOxD3L
   94 1159346 [main] git 3244 normalize_posix_path: /cygdrive/c/workspace/git/git-1.5.3/.git/objects/tmp_obj_rOxD3L = normalize_posix_path (/cygdrive/c/workspace/git/git-1.5.3/.git/objects/tmp_obj_rOxD3L)
   65 1159411 [main] git 3244 mount_info::conv_to_win32_path: conv_to_win32_path (/cygdrive/c/workspace/git/git-1.5.3/.git/objects/tmp_obj_rOxD3L)
  104 1159515 [main] git 3244 mount_info::cygdrive_win32_path: src '/cygdrive/c/workspace/git/git-1.5.3/.git/objects/tmp_obj_rOxD3L', dst 'c:\workspace\git\git-1.5.3\.git\objects\tmp_obj_rOxD3L'
   73 1159588 [main] git 3244 set_flags: flags: binary (0x2)
   62 1159650 [main] git 3244 mount_info::conv_to_win32_path: src_path /cygdrive/c/workspace/git/git-1.5.3/.git/objects/tmp_obj_rOxD3L, dst c:\workspace\git\git-1.5.3\.git\objects\tmp_obj_rOxD3L, flags 0x2A, rc 0
  130 1159780 [main] git 3244 symlink_info::check: not a symlink
   66 1159846 [main] git 3244 symlink_info::check: 0 = symlink.check (c:\workspace\git\git-1.5.3\.git\objects\tmp_obj_rOxD3L, 0x22C110) (0x2A)
   67 1159913 [main] git 3244 path_conv::check: this->path(c:\workspace\git\git-1.5.3\.git\objects\tmp_obj_rOxD3L), has_acls(1)
   64 1159977 [main] git 3244 unlink: _unlink (c:\workspace\git\git-1.5.3\.git\objects\tmp_obj_rOxD3L)
  763 1160740 [main] git 3244 unlink: 1 = CloseHandle (0x6D0)
  144 1160884 [main] git 3244 unlink: CreateFile (FILE_FLAG_DELETE_ON_CLOSE) succeeded
   66 1160950 [main] git 3244 unlink: 0 = unlink (/cygdrive/c/workspace/git/git-1.5.3/.git/objects/tmp_obj_rOxD3L)

Could you locate move_temp_to_file and make it unconditionally rename
the tempfile into target sha1 file? It should become something like that:

int move_temp_to_file(const char *tmpfile, const char *filename)
{
	int ret = link_temp_to_file(tmpfile, filename);

	/*
	 * Coda hack - coda doesn't like cross-directory links,
	 * so we fall back to a rename, which will mean that it
	 * won't be able to check collisions, but that's not a
	 * big deal.
	 *
	 * The same holds for FAT formatted media.
	 *
	 * When this succeeds, we just return 0. We have nothing
	 * left to unlink.
	 */
	if (!rename(tmpfile, filename))
		return 0;
	ret = errno;
	unlink(tmpfile);
	if (ret) {
		if (ret != EEXIST) {
			return error("unable to write sha1 filename %s: %s\n", filename, strerror(ret));
		}
		/* FIXME!!! Collision check here ? */
		return error("failed to write sha1 filename %s: %s\n", filename, strerror(ret));
	}

	return 0;
}

Does someone know, why this function seem to return 0 (success) on
something which looks like an SHA1 collision? And destroy the
tempfile, even though it is not moved anywhere.
